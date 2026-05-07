package com.tourism.platform.security;

import com.tourism.platform.model.Admin;
import com.tourism.platform.model.Staff;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class BookingManagementInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=booking");
            return false;
        }
        Admin admin = (Admin) session.getAttribute(SessionKeys.ADMIN);
        Staff staff = (Staff) session.getAttribute(SessionKeys.STAFF);
        if (admin != null || staff != null) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + "/login?error=booking");
        return false;
    }
}
