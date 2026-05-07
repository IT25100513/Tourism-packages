package com.tourism.platform.util;

import com.tourism.platform.model.Booking;
import com.tourism.platform.model.TourPackage;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Customer may review when the trip is admin-marked {@code COMPLETED}, or when it was
 * {@code CONFIRMED} and today is strictly after the last day of the itinerary.
 */
public final class TripFeedbackRules {

    /** Align “today” with Sri Lanka for coursework consistency. */
    public static final ZoneId APP_ZONE = ZoneId.of("Asia/Colombo");

    private static final DateTimeFormatter[] ALT_FORMATS = new DateTimeFormatter[]{
            DateTimeFormatter.ofPattern("d/M/uuuu"),
            DateTimeFormatter.ofPattern("uuuu-M-d"),
            DateTimeFormatter.ofPattern("M/d/uuuu")
    };

    private TripFeedbackRules() {
    }

    public static LocalDate today() {
        return LocalDate.now(APP_ZONE);
    }

    public static LocalDate parseBookingStart(String bookingDateRaw) {
        if (bookingDateRaw == null || bookingDateRaw.isBlank()) {
            return null;
        }
        String t = bookingDateRaw.trim();
        try {
            return LocalDate.parse(t);
        } catch (DateTimeParseException ignored) {
            // fall through
        }
        for (DateTimeFormatter f : ALT_FORMATS) {
            try {
                return LocalDate.parse(t, f);
            } catch (DateTimeParseException ignored) {
                // next
            }
        }
        return null;
    }

    /**
     * Last calendar day counted as part of the trip ({@code durationDays} includes start day).
     */
    public static LocalDate lastItineraryDay(LocalDate start, int durationDays) {
        int d = Math.max(durationDays, 1);
        return start.plusDays(d - 1L);
    }

    /**
     * @return {@code true} when admin marked {@code COMPLETED}, or confirmed and dates have passed.
     */
    public static boolean isEligibleCompletedTrip(Booking b, TourPackage pkg, LocalDate today) {
        if (b == null || pkg == null) {
            return false;
        }
        String st = b.getStatus();
        if (st == null) {
            return false;
        }
        st = st.trim();
        if ("COMPLETED".equalsIgnoreCase(st)) {
            return true;
        }
        if (!"CONFIRMED".equalsIgnoreCase(st)) {
            return false;
        }
        LocalDate start = parseBookingStart(b.getBookingDate());
        if (start == null) {
            return false;
        }
        LocalDate lastDay = lastItineraryDay(start, pkg.getDurationDays());
        return today.isAfter(lastDay);
    }
}
