package com.tourism.platform.controller;

import com.tourism.platform.model.Admin;
import com.tourism.platform.model.Staff;
import com.tourism.platform.security.SessionKeys;
import com.tourism.platform.service.BookingService;
import com.tourism.platform.service.DestinationService;
import com.tourism.platform.service.FeedbackService;
import com.tourism.platform.service.PackageService;
import com.tourism.platform.service.StaffService;
import com.tourism.platform.service.UserService;
import com.tourism.platform.util.ValidationSupport;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final BookingService bookingService;
    private final PackageService packageService;
    private final FeedbackService feedbackService;
    private final DestinationService destinationService;
    private final StaffService staffService;

    public AdminController(UserService userService,
                           BookingService bookingService,
                           PackageService packageService,
                           FeedbackService feedbackService,
                           DestinationService destinationService,
                           StaffService staffService) {
        this.userService = userService;
        this.bookingService = bookingService;
        this.packageService = packageService;
        this.feedbackService = feedbackService;
        this.destinationService = destinationService;
        this.staffService = staffService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute(SessionKeys.ADMIN);
        model.addAttribute("admin", admin);
        model.addAttribute("userCount", userService.findAll().size());
        model.addAttribute("bookingCount", bookingService.findAll().size());
        model.addAttribute("packageCount", packageService.findAll().size());
        model.addAttribute("destinationCount", destinationService.findAll().size());
        model.addAttribute("feedbackCount", feedbackService.findAll().size());
        model.addAttribute("staffCount", staffService.findAll().size());
        return "admin-dashboard";
    }

    @GetMapping({"/staff", "/staff/", "/staff/list"})
    public String staffList(@RequestParam(value = "q", required = false) String query, Model model) {
        model.addAttribute("staffList", staffService.search(query));
        model.addAttribute("searchQuery", query == null ? "" : query);
        return "admin/staff-list";
    }

    @GetMapping("/staff/new")
    public String staffNewForm(Model model) {
        model.addAttribute("staff", new Staff());
        model.addAttribute("editMode", false);
        return "admin/staff-form";
    }

    @PostMapping("/staff/create")
    public String staffCreate(@RequestParam String username,
                              @RequestParam String password,
                              @RequestParam String fullName,
                              @RequestParam String email,
                              @RequestParam String department,
                              Model model) {
        if (invalidStaffInput(username, password, fullName, email, department)) {
            model.addAttribute("message", "All fields are required.");
            Staff temp = blankStaff(username, password, fullName, email, department);
            model.addAttribute("staff", temp);
            model.addAttribute("editMode", false);
            return "admin/staff-form";
        }
        if (!ValidationSupport.validUsername(username)) {
            model.addAttribute("message", "Username must be 3–120 characters (letters, digits, underscore, dot, or hyphen).");
            model.addAttribute("staff", blankStaff(username, password, fullName, email, department));
            model.addAttribute("editMode", false);
            return "admin/staff-form";
        }
        if (!ValidationSupport.validEmail(email)) {
            model.addAttribute("message", "Enter a valid email address.");
            model.addAttribute("staff", blankStaff(username, password, fullName, email, department));
            model.addAttribute("editMode", false);
            return "admin/staff-form";
        }
        if (staffService.usernameExistsIgnoreCase(username, null)) {
            model.addAttribute("message", "Username already exists.");
            model.addAttribute("staff", blankStaff(username, password, fullName, email, department));
            model.addAttribute("editMode", false);
            return "admin/staff-form";
        }
        staffService.save(blankStaff(username, password, fullName, email, department));
        return "redirect:/admin/staff/list";
    }

    @GetMapping("/staff/edit")
    public String staffEdit(@RequestParam Long id, Model model) {
        return staffService.findById(id)
                .map(s -> {
                    model.addAttribute("staff", s);
                    model.addAttribute("editMode", true);
                    return "admin/staff-form";
                })
                .orElse("redirect:/admin/staff/list");
    }

    @PostMapping("/staff/update")
    public String staffUpdate(@RequestParam Long id,
                              @RequestParam String username,
                              @RequestParam String password,
                              @RequestParam String fullName,
                              @RequestParam String email,
                              @RequestParam String department,
                              Model model) {
        if (invalidStaffInput(username, password, fullName, email, department)) {
            model.addAttribute("message", "All fields are required.");
            model.addAttribute("staff", existingStaff(id, username, password, fullName, email, department));
            model.addAttribute("editMode", true);
            return "admin/staff-form";
        }
        if (!ValidationSupport.validUsername(username)) {
            model.addAttribute("message", "Username must be 3–120 characters (letters, digits, underscore, dot, or hyphen).");
            model.addAttribute("staff", existingStaff(id, username, password, fullName, email, department));
            model.addAttribute("editMode", true);
            return "admin/staff-form";
        }
        if (!ValidationSupport.validEmail(email)) {
            model.addAttribute("message", "Enter a valid email address.");
            model.addAttribute("staff", existingStaff(id, username, password, fullName, email, department));
            model.addAttribute("editMode", true);
            return "admin/staff-form";
        }
        if (staffService.usernameExistsIgnoreCase(username, id)) {
            model.addAttribute("message", "Username already exists.");
            model.addAttribute("staff", existingStaff(id, username, password, fullName, email, department));
            model.addAttribute("editMode", true);
            return "admin/staff-form";
        }
        staffService.save(existingStaff(id, username, password, fullName, email, department));
        return "redirect:/admin/staff/list";
    }

    @GetMapping("/staff/delete")
    public String staffDelete(@RequestParam Long id) {
        staffService.deleteById(id);
        return "redirect:/admin/staff/list";
    }

    private static boolean invalidStaffInput(String username,
                                             String password,
                                             String fullName,
                                             String email,
                                             String department) {
        return username == null || username.isBlank()
                || password == null || password.isBlank()
                || fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || department == null || department.isBlank();
    }

    private static Staff blankStaff(String username,
                                    String password,
                                    String fullName,
                                    String email,
                                    String department) {
        Staff s = new Staff();
        s.setUsername(ValidationSupport.trimLen(username.trim(), 120));
        s.setPassword(password);
        s.setFullName(ValidationSupport.trimLen(fullName.trim(), 160));
        s.setEmail(ValidationSupport.trimLen(email.trim(), 160));
        s.setDepartment(ValidationSupport.trimLen(department.trim(), 120));
        return s;
    }

    private static Staff existingStaff(Long id,
                                       String username,
                                       String password,
                                       String fullName,
                                       String email,
                                       String department) {
        Staff s = blankStaff(username, password, fullName, email, department);
        s.setId(id);
        return s;
    }
}