package com.tourism.platform.service;

import com.tourism.platform.model.Destination;
import com.tourism.platform.util.DelimitedFileUtil;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * destinations.txt:<br/>
 * {@code id,name,country,description}<br/>
 * Use quotes around {@code description} if it contains commas.
 */
@Service
public class DestinationService {

    private final Path destinationsFile;
    private final DelimitedFileUtil delim;

    public DestinationService(Path dataDirectory, DelimitedFileUtil delim) {
        this.destinationsFile = dataDirectory.resolve("destinations.txt");
        this.delim = delim;
    }

    public List<Destination> findAll() {
        return loadAll().stream()
                .sorted(Comparator.comparing(Destination::getId, Comparator.nullsLast(Long::compareTo)))
                .collect(Collectors.toList());
    }

    public Optional<Destination> findById(Long id) {
        return findAll().stream().filter(d -> Objects.equals(d.getId(), id)).findFirst();
    }

    public Destination save(Destination item) {
        List<Destination> all = loadAll();
        if (item.getId() == null) {
            item.setId(nextId(all));
            all.add(item);
        } else {
            boolean replaced = false;
            for (int i = 0; i < all.size(); i++) {
                if (Objects.equals(all.get(i).getId(), item.getId())) {
                    all.set(i, item);
                    replaced = true;
                    break;
                }
            }
            if (!replaced) {
                all.add(item);
            }
        }
        writeAll(all);
        return item;
    }

    public void deleteById(Long id) {
        List<Destination> all = loadAll();
        all.removeIf(d -> Objects.equals(d.getId(), id));
        writeAll(all);
    }

    private List<Destination> loadAll() {
        try {
            List<Destination> list = new ArrayList<>();
            for (String line : delim.readLines(destinationsFile)) {
                List<String> p = delim.parseCsvLine(line);
                if (p.size() < 4) {
                    continue;
                }
                Destination d = new Destination();
                d.setId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(0))));
                d.setName(DelimitedFileUtil.safeTrim(p.get(1)));
                d.setCountry(DelimitedFileUtil.safeTrim(p.get(2)));
                d.setDescription(DelimitedFileUtil.safeTrim(p.get(3)));
                list.add(d);
            }
            return list;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private void writeAll(List<Destination> all) {
        List<String> lines = new ArrayList<>();
        lines.add("# id,name,country,description");
        for (Destination d : all.stream().sorted(Comparator.comparing(Destination::getId, Comparator.nullsLast(Long::compareTo)))
                .toList()) {
            lines.add(delim.formatLine(List.of(
                    String.valueOf(d.getId()),
                    d.getName(),
                    d.getCountry(),
                    d.getDescription() == null ? "" : d.getDescription())));
        }
        try {
            delim.writeLines(destinationsFile, lines);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private long nextId(List<Destination> list) {
        return list.stream()
                .map(Destination::getId)
                .filter(Objects::nonNull)
                .max(Long::compareTo)
                .map(v -> v + 1)
                .orElse(1L);
    }
}
