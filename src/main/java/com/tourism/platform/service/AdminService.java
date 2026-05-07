package com.tourism.platform.service;

import com.tourism.platform.model.Admin;
import com.tourism.platform.util.DelimitedFileUtil;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * admins.txt — comma-separated:<br/>
 * {@code id,username,password,fullName,email}
 */
@Service
public class AdminService {

    private final Path adminsFile;
    private final DelimitedFileUtil delim;

    public AdminService(Path dataDirectory, DelimitedFileUtil delim) {
        this.adminsFile = dataDirectory.resolve("admins.txt");
        this.delim = delim;
    }

    public List<Admin> findAll() {
        return loadAll();
    }

    public Optional<Admin> findByUsernamePassword(String username, String password) {
        String u = DelimitedFileUtil.safeTrim(username);
        String p = DelimitedFileUtil.safeTrim(password);
        return findAll().stream()
                .filter(a -> u.equalsIgnoreCase(DelimitedFileUtil.safeTrim(a.getUsername()))
                        && p.equals(DelimitedFileUtil.safeTrim(a.getPassword())))
                .findFirst();
    }

    private List<Admin> loadAll() {
        try {
            List<Admin> list = new ArrayList<>();
            for (String line : delim.readLines(adminsFile)) {
                List<String> p = delim.parseCsvLine(line);
                if (p.size() < 5) {
                    continue;
                }
                Admin a = new Admin();
                a.setId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(0))));
                a.setUsername(DelimitedFileUtil.safeTrim(p.get(1)));
                a.setPassword(DelimitedFileUtil.safeTrim(p.get(2)));
                a.setFullName(DelimitedFileUtil.safeTrim(p.get(3)));
                a.setEmail(DelimitedFileUtil.safeTrim(p.get(4)));
                list.add(a);
            }
            return list;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }
}
