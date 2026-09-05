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

@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        User user = userService.findByEmail(email);

        if (user != null) {
            String otpCode = EmailUtil.generateOTP();
            
            user.setOtpCode(otpCode);
            userService.update(user);

            String subject = "Mã OTP khôi phục mật khẩu | Catfeine";
            String body = "Chào " + user.getFullName() + ",\n\nMã xác nhận OTP để khôi phục mật khẩu của bạn là: " + otpCode + "\n\nVui lòng không chia sẻ mã này cho bất kỳ ai.";
            boolean isSent = EmailUtil.sendEmail(email, subject, body);

            if (isSent) {
                resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email + "&action=reset");
            } else {
                req.setAttribute("error", "Lỗi gửi mail. Vui lòng thử lại sau.");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Email này chưa được đăng ký trong hệ thống!");
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }
}