package com.tourism.platform.security;

import com.tourism.platform.model.Staff;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class StaffAuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        Staff staff = session == null ? null : (Staff) session.getAttribute(SessionKeys.STAFF);
        if (staff == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=staff");
            return false;
        }
        return true;
    }
}
