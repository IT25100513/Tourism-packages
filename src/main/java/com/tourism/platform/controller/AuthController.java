package com.tourism.platform.controller;

import com.tourism.platform.model.Admin;
import com.tourism.platform.model.Staff;
import com.tourism.platform.security.SessionKeys;
import com.tourism.platform.service.AdminService;
import com.tourism.platform.service.StaffService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
@RequestMapping
public class AuthController {

    private final AdminService adminService;
    private final StaffService staffService;

    public AuthController(AdminService adminService, StaffService staffService) {
        this.adminService = adminService;
        this.staffService = staffService;
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error, Model model) {
        model.addAttribute("adminCount", adminService.findAll().size());
        model.addAttribute("staffCount", staffService.findAll().size());
        if ("admin".equals(error)) {
            model.addAttribute("message", "Please sign in as an administrator.");
        } else if ("staff".equals(error)) {
            model.addAttribute("message", "Please sign in as a staff member.");
        } else if ("booking".equals(error)) {
            model.addAttribute("message", "Sign in as admin or staff to manage bookings.");
        }
        return "login";
    }

    @PostMapping("/auth/admin/login")
    public String adminLogin(@RequestParam String username,
                             @RequestParam String password,
                             HttpServletRequest request,
                             Model model) {
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            model.addAttribute("message", "Username and password are required.");
            model.addAttribute("adminCount", adminService.findAll().size());
            model.addAttribute("staffCount", staffService.findAll().size());
            return "login";
        }
        Optional<Admin> match = adminService.findByUsernamePassword(username, password);
        if (match.isEmpty()) {
            model.addAttribute("message", "Invalid admin credentials.");
            model.addAttribute("adminCount", adminService.findAll().size());
            model.addAttribute("staffCount", staffService.findAll().size());
            return "login";
        }
        HttpSession session = request.getSession(true);
        session.invalidate();
        HttpSession fresh = request.getSession(true);
        fresh.setAttribute(SessionKeys.ADMIN, match.get());
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/auth/staff/login")
    public String staffLogin(@RequestParam String username,
                             @RequestParam String password,
                             HttpServletRequest request,
                             Model model) {
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            model.addAttribute("message", "Username and password are required.");
            model.addAttribute("adminCount", adminService.findAll().size());
            model.addAttribute("staffCount", staffService.findAll().size());
            return "login";
        }
        Optional<Staff> match = staffService.findByUsernamePassword(username, password);
        if (match.isEmpty()) {
            model.addAttribute("message", "Invalid staff credentials.");
            model.addAttribute("adminCount", adminService.findAll().size());
            model.addAttribute("staffCount", staffService.findAll().size());
            return "login";
        }
        HttpSession session = request.getSession(true);
        session.invalidate();
        HttpSession fresh = request.getSession(true);
        fresh.setAttribute(SessionKeys.STAFF, match.get());
        return "redirect:/staff/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }
}
