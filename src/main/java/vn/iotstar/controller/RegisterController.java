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
import vn.iotstar.util.EmailUtil;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        String otpCode = EmailUtil.generateOTP();

        User existingUser = userService.findByEmail(email);
        
        if (existingUser != null) {

            existingUser.setFullName(fullName);
            existingUser.setPassword(password);
            existingUser.setOtpCode(otpCode);
            existingUser.setActive(false);
            userService.update(existingUser);
        } else {
            User newUser = new User(email, password, otpCode, false);
            newUser.setFullName(fullName);
            userService.insert(newUser);
        }

        String subject = "Mã xác nhận OTP đăng ký tài khoản";
        String body = "Chào " + fullName + ",\n\nMã xác nhận OTP của bạn là: " + otpCode + "\n\nVui lòng nhập mã này để kích hoạt tài khoản.";
        boolean isSent = EmailUtil.sendEmail(email, subject, body);

        if (isSent) {
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email);
        } else {
            req.setAttribute("error", "Có lỗi xảy ra khi gửi email OTP! Vui lòng kiểm tra lại kết nối mạng hoặc cấu hình email.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}