package com.tourism.platform.service;

import com.tourism.platform.model.User;
import com.tourism.platform.util.DelimitedFileUtil;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Line format ({@code users.txt}), one row per traveler:<br/>
 * {@code id,name,email,username,phone,type,password}<br/>
 * Password is optional: if omitted, only 6 columns are read and login password defaults to username.
 */
@Service
public class UserService {

    private final Path usersFile;
    private final DelimitedFileUtil delim;

    public UserService(Path dataDirectory, DelimitedFileUtil delim) {
        this.usersFile = dataDirectory.resolve("users.txt");
        this.delim = delim;
    }

    public List<User> findAll() {
        return loadAll().stream()
                .sorted(Comparator.comparing(User::getId, Comparator.nullsLast(String::compareTo)))
                .collect(Collectors.toList());
    }

    public List<User> search(String query) {
        String q = DelimitedFileUtil.safeTrim(query).toLowerCase();
        if (q.isEmpty()) {
            return findAll();
        }
        return findAll().stream()
                .filter(u -> contains(u.getUsername(), q)
                        || contains(u.getFullName(), q)
                        || contains(u.getEmail(), q)
                        || contains(u.getPhone(), q)
                        || contains(u.getUserType(), q))
                .collect(Collectors.toList());
    }

    private boolean contains(String field, String q) {
        return field != null && field.toLowerCase().contains(q);
    }

    public Optional<User> findById(String id) {
        return findAll().stream().filter(u -> Objects.equals(u.getId(), id)).findFirst();
    }

    public Optional<User> findByUsernamePassword(String username, String password) {
        String u = DelimitedFileUtil.safeTrim(username);
        String p = DelimitedFileUtil.safeTrim(password);
        return findAll().stream()
                .filter(us -> u.equalsIgnoreCase(DelimitedFileUtil.safeTrim(us.getUsername()))
                        && p.equals(DelimitedFileUtil.safeTrim(us.getPassword())))
                .findFirst();
    }

    public boolean usernameExistsIgnoreCase(String username, String excludingUserId) {
        String key = DelimitedFileUtil.safeTrim(username).toLowerCase();
        return findAll().stream()
                .filter(us -> excludingUserId == null || !Objects.equals(us.getId(), excludingUserId))
                .anyMatch(us -> key.equals(DelimitedFileUtil.safeTrim(us.getUsername()).toLowerCase()));
    }

    public User save(User user) {
        List<User> all = loadAll();
        if (user.getId() == null || user.getId().isBlank()) {
            user.setId(UUID.randomUUID().toString());
            all.add(user);
        } else {
            boolean replaced = false;
            for (int i = 0; i < all.size(); i++) {
                if (Objects.equals(all.get(i).getId(), user.getId())) {
                    all.set(i, user);
                    replaced = true;
                    break;
                }
            }
            if (!replaced) {
                all.add(user);
            }
        }
        writeAll(all);
        return user;
    }

    public void deleteById(String id) {
        List<User> all = loadAll();
        all.removeIf(u -> Objects.equals(u.getId(), id));
        writeAll(all);
    }

    private List<User> loadAll() {
        try {
            List<User> users = new ArrayList<>();
            for (String line : delim.readLines(usersFile)) {
                List<String> p = delim.parseCsvLine(line);
                if (p.size() < 6) {
                    continue;
                }
                users.add(parseUser(p));
            }
            return users;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private static User parseUser(List<String> p) {
        User u = new User();
        u.setId(DelimitedFileUtil.safeTrim(p.get(0)));
        u.setFullName(DelimitedFileUtil.safeTrim(p.get(1)));
        u.setEmail(DelimitedFileUtil.safeTrim(p.get(2)));
        u.setUsername(DelimitedFileUtil.safeTrim(p.get(3)));
        u.setPhone(DelimitedFileUtil.safeTrim(p.get(4)));
        u.setUserType(DelimitedFileUtil.safeTrim(p.get(5)));
        String passwordCol = p.size() >= 7 ? DelimitedFileUtil.safeTrim(p.get(6)) : "";
        u.setPassword(passwordCol.isBlank() ? u.getUsername() : passwordCol);
        return u;
    }

    private void writeAll(List<User> users) {
        List<String> lines = new ArrayList<>();
        lines.add("# id,name,email,username,phone,type,password");
        for (User u : users.stream().sorted(Comparator.comparing(User::getId, Comparator.nullsLast(String::compareTo)))
                .toList()) {
            lines.add(delim.formatLine(List.of(
                    u.getId(),
                    u.getFullName(),
                    u.getEmail(),
                    u.getUsername(),
                    u.getPhone(),
                    (u.getUserType() == null || u.getUserType().isBlank()) ? "Passenger" : u.getUserType(),
                    u.getPassword())));
        }
        try {
            delim.writeLines(usersFile, lines);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }
}
