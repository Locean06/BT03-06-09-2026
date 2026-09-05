package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String action = req.getParameter("action");

        User user = userService.findByEmail(email);

        if (user != null && user.getOtpCode().equals(otp)) {
            
            user.setOtpCode(null); 
            
            if ("reset".equals(action)) {
                userService.update(user);
                resp.sendRedirect(req.getContextPath() + "/reset-password?email=" + email);
            } else {
                user.setActive(true);
                userService.update(user);
                resp.sendRedirect(req.getContextPath() + "/login?message=success");
            }
        } else {
            req.setAttribute("error", "Mã OTP không chính xác!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}