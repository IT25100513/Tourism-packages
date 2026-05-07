package com.tourism.platform.service;

import com.tourism.platform.model.Booking;
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
 * bookings.txt:<br/>
 * {@code id,userId,packageId,status,bookingDate,notes}<br/>
 * {@code status} may be {@code PENDING}, {@code CONFIRMED}, {@code CANCELLED}, or admin-set {@code COMPLETED}.<br/>
 * {@code bookingDate}: customer’s preferred trip start (ISO yyyy-MM-dd)<br/>
 * {@code userId} matches UUID in users.txt.
 */
@Service
public class BookingService {

    private final Path bookingsFile;
    private final DelimitedFileUtil delim;

    public BookingService(Path dataDirectory, DelimitedFileUtil delim) {
        this.bookingsFile = dataDirectory.resolve("bookings.txt");
        this.delim = delim;
    }

    public List<Booking> findAll() {
        return loadAll().stream()
                .sorted(Comparator.comparing(Booking::getId, Comparator.nullsLast(Long::compareTo)))
                .collect(Collectors.toList());
    }

    public List<Booking> findByUserId(String userId) {
        return findAll().stream()
                .filter(b -> Objects.equals(b.getUserId(), userId))
                .collect(Collectors.toList());
    }

    public Optional<Booking> findById(Long id) {
        return findAll().stream().filter(b -> Objects.equals(b.getId(), id)).findFirst();
    }

    public Booking save(Booking booking) {
        List<Booking> all = loadAll();
        if (booking.getId() == null) {
            booking.setId(nextId(all));
            all.add(booking);
        } else {
            boolean replaced = false;
            for (int i = 0; i < all.size(); i++) {
                if (Objects.equals(all.get(i).getId(), booking.getId())) {
                    all.set(i, booking);
                    replaced = true;
                    break;
                }
            }
            if (!replaced) {
                all.add(booking);
            }
        }
        writeAll(all);
        return booking;
    }

    public void deleteById(Long id) {
        List<Booking> all = loadAll();
        all.removeIf(b -> Objects.equals(b.getId(), id));
        writeAll(all);
    }

    private List<Booking> loadAll() {
        try {
            List<Booking> list = new ArrayList<>();
            for (String line : delim.readLines(bookingsFile)) {
                List<String> p = delim.parseCsvLine(line);
                if (p.size() < 6) {
                    continue;
                }
                Booking b = new Booking();
                b.setId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(0))));
                b.setUserId(DelimitedFileUtil.safeTrim(p.get(1)));
                b.setPackageId(Long.parseLong(DelimitedFileUtil.safeTrim(p.get(2))));
                b.setStatus(DelimitedFileUtil.safeTrim(p.get(3)));
                b.setBookingDate(DelimitedFileUtil.safeTrim(p.get(4)));
                b.setNotes(DelimitedFileUtil.safeTrim(p.get(5)));
                list.add(b);
            }
            return list;
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private void writeAll(List<Booking> all) {
        List<String> lines = new ArrayList<>();
        lines.add("# id,userId,packageId,status,bookingDate,notes");
        for (Booking b : all.stream().sorted(Comparator.comparing(Booking::getId, Comparator.nullsLast(Long::compareTo)))
                .toList()) {
            lines.add(delim.formatLine(List.of(
                    String.valueOf(b.getId()),
                    b.getUserId(),
                    String.valueOf(b.getPackageId()),
                    b.getStatus(),
                    b.getBookingDate(),
                    b.getNotes() == null ? "" : b.getNotes())));
        }
        try {
            delim.writeLines(bookingsFile, lines);
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }
    }

    private long nextId(List<Booking> list) {
        return list.stream()
                .map(Booking::getId)
                .filter(Objects::nonNull)
                .max(Long::compareTo)
                .map(v -> v + 1)
                .orElse(1L);
    }
}
