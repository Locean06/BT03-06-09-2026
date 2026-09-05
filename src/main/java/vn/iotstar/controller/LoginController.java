package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.findByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            
            if (!user.isActive()) {
                req.setAttribute("error", "Tài khoản chưa được kích hoạt OTP. Vui lòng kiểm tra email!");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }
            
            HttpSession session = req.getSession();
            session.setAttribute("account", user);
            
            if (user.getEmail().toLowerCase().contains("admin")) {
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            } 
            else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
            
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}