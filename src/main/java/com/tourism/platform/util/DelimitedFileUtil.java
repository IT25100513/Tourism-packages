package com.tourism.platform.util;

import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Reads and writes comma-separated plain text lines (supports quoted fields containing commas).
 * Example user line:<br/>
 * {@code 7d50dc82-5687-4786-87b8-1ec03a96ba8d,Dinuja,hello@example.com,n,0712345679,Passenger,secret}
 */
@Component
public class DelimitedFileUtil {

    public static String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }

    public List<String> readLines(Path path) throws IOException {
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }
        List<String> out = new ArrayList<>();
        for (String raw : Files.readAllLines(path, StandardCharsets.UTF_8)) {
            String line = safeTrim(raw);
            if (line.isEmpty() || line.startsWith("#")) {
                continue;
            }
            out.add(line);
        }
        return out;
    }

    /**
     * Splits CSV respecting double-quoted spans.
     */
    public List<String> parseCsvLine(String line) {
        List<String> fields = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        boolean inQuotes = false;
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (inQuotes) {
                if (c == '"') {
                    if (i + 1 < line.length() && line.charAt(i + 1) == '"') {
                        sb.append('"');
                        i++;
                    } else {
                        inQuotes = false;
                    }
                } else {
                    sb.append(c);
                }
            } else if (c == '"') {
                inQuotes = true;
            } else if (c == ',') {
                fields.add(sb.toString().trim());
                sb.setLength(0);
            } else {
                sb.append(c);
            }
        }
        fields.add(sb.toString().trim());
        return fields;
    }

    public String encodeField(String value) {
        String s = value == null ? "" : value;
        if (s.contains(",") || s.contains("\"") || s.contains("\n") || s.contains("\r")) {
            return '"' + s.replace("\"", "\"\"") + '"';
        }
        return s;
    }

    public String formatLine(List<String> fields) {
        return fields.stream().map(this::encodeField).collect(Collectors.joining(","));
    }

    public String formatLine(String... fields) {
        return formatLine(Arrays.stream(fields).toList());
    }

    public void writeLines(Path path, List<String> lines) throws IOException {
        Files.createDirectories(Objects.requireNonNull(path.getParent()));
        Files.write(path, lines, StandardCharsets.UTF_8);
    }
}
