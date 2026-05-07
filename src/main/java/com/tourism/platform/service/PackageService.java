package com.tourism.platform.service;

import com.tourism.platform.model.TourPackage;
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
 * packages.txt:<br/>
 * {@code id,name,price(LKR),durationDays,destinationId,description}
 */
@Service
public class PackageService {

    private final Path packagesFile;
    private final DelimitedFileUtil delim;

    public PackageService(Path dataDirectory, DelimitedFileUtil delim) {
        this.packagesFile = dataDirectory.resolve("packages.txt");
        this.delim = delim;
    }

    public List<TourPackage> findAll() {
        return loadAll().stream()
                .sorted(Comparator.comparing(TourPackage::getId, Comparator.nullsLast(Long::compareTo)))
                .collect(Collectors.toList());
    }

    public Optional<TourPackage> findById(Long id) {
        return findAll().stream().filter(p -> Objects.equals(p.getId(), id)).findFirst();
    }

    public TourPackage save(TourPackage item) {
        List<TourPackage> all = loadAll();
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
        List<TourPackage> all = loadAll();
        all.removeIf(p -> Objects.equals(p.getId(), id));
        writeAll(all);
    }

    private List<TourPackage> loadAll() {
        try {
            List<TourPackage> list = new ArrayList<>();
            for (String line : delim.readLines(packagesFile)) {
                List<String> p = delim.parseCsvLine(line);
                if (p.size() < 6) {
                    continue;
                }
                TourPackage t = new TourPackage();
                t.setId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(0))));
                t.setName(DelimitedFileUtil.safeTrim(p.get(1)));
                t.setPrice(Double.parseDouble(DelimitedFileUtil.safeTrim(p.get(2))));
                t.setDurationDays(Integer.parseInt(DelimitedFileUtil.safeTrim(p.get(3))));
                t.setDestinationId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(4))));
                t.setDescription(DelimitedFileUtil.safeTrim(p.get(5)));
                list.add(t);
            }
            return list;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private void writeAll(List<TourPackage> all) {
        List<String> lines = new ArrayList<>();
        lines.add("# id,name,price(LKR),durationDays,destinationId,description");
        for (TourPackage p : all.stream().sorted(Comparator.comparing(TourPackage::getId, Comparator.nullsLast(Long::compareTo)))
                .toList()) {
            lines.add(delim.formatLine(List.of(
                    String.valueOf(p.getId()),
                    p.getName(),
                    String.valueOf(p.getPrice()),
                    String.valueOf(p.getDurationDays()),
                    String.valueOf(p.getDestinationId()),
                    p.getDescription() == null ? "" : p.getDescription())));
        }
        try {
            delim.writeLines(packagesFile, lines);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private long nextId(List<TourPackage> list) {
        return list.stream()
                .map(TourPackage::getId)
                .filter(Objects::nonNull)
                .max(Long::compareTo)
                .map(v -> v + 1)
                .orElse(1L);
    }
}
