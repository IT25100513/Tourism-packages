package com.tourism.platform.security;

import com.tourism.platform.model.Admin;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminAuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        Admin admin = session == null ? null : (Admin) session.getAttribute(SessionKeys.ADMIN);
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=admin");
            return false;
        }
        return true;
    }
}
