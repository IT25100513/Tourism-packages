package com.tourism.platform.controller;

import com.tourism.platform.model.Staff;
import com.tourism.platform.security.SessionKeys;
import com.tourism.platform.service.BookingService;
import com.tourism.platform.service.DestinationService;
import com.tourism.platform.service.FeedbackService;
import com.tourism.platform.service.PackageService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/staff")
public class StaffController {

    private final PackageService packageService;
    private final DestinationService destinationService;
    private final BookingService bookingService;
    private final FeedbackService feedbackService;

    public StaffController(PackageService packageService,
                           DestinationService destinationService,
                           BookingService bookingService,
                           FeedbackService feedbackService) {
        this.packageService = packageService;
        this.destinationService = destinationService;
        this.bookingService = bookingService;
        this.feedbackService = feedbackService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Staff staff = (Staff) session.getAttribute(SessionKeys.STAFF);
        model.addAttribute("staff", staff);
        model.addAttribute("bookingCount", bookingService.findAll().size());
        model.addAttribute("packageCount", packageService.findAll().size());
        model.addAttribute("destinationCount", destinationService.findAll().size());
        return "staff-dashboard";
    }

    @GetMapping("/packages")
    public String packages(Model model) {
        model.addAttribute("packages", packageService.findAll());
        model.addAttribute("destinations", destinationService.findAll());
        return "staff/package-browse";
    }

    @GetMapping("/destinations")
    public String destinations(Model model) {
        model.addAttribute("destinations", destinationService.findAll());
        return "staff/destination-browse";
    }

    @GetMapping("/feedback")
    public String feedback(Model model) {
        model.addAttribute("feedbackList", feedbackService.findAll());
        return "staff/feedback-view";
    }
}
