<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu | Catfeine</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --bg-cream: #fcfbf9; --brand-green: #144d29; --text-dark: #111111; --text-muted: #767676; --border-light: #e5e5e5; }
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background-color: var(--bg-cream); display: flex; justify-content: center; align-items: center; min-height: 100vh; color: var(--text-dark); }
        
        .auth-container { background: #ffffff; width: 100%; max-width: 420px; padding: 50px 40px; border: 1px solid var(--border-light); }
        .auth-logo { text-align: center; margin-bottom: 25px; }
        .auth-logo img { height: 70px; object-fit: contain; }
        
        .auth-header { text-align: center; margin-bottom: 30px; }
        .auth-header h2 { font-size: 18px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; }
        .auth-header p { color: var(--text-muted); font-size: 13px; margin-top: 8px; line-height: 1.5; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-dark); }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid var(--border-light); font-size: 14px; outline: none; transition: all 0.3s; background: transparent; }
        .form-control:focus { border-color: var(--brand-green); }

        .btn-submit { width: 100%; background: var(--text-dark); color: var(--bg-cream); border: 1px solid var(--text-dark); padding: 14px; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn-submit:hover { background: var(--brand-green); border-color: var(--brand-green); }

        .alert-error { background: #fff0f0; color: #d0021b; padding: 12px; font-size: 13px; margin-bottom: 20px; border: 1px solid #d0021b; text-align: center; }
        .alert-success { background: #f4fbf7; color: var(--brand-green); padding: 12px; font-size: 13px; margin-bottom: 20px; border: 1px solid var(--brand-green); text-align: center; }

        .auth-footer { text-align: center; margin-top: 25px; font-size: 13px; color: var(--text-muted); }
        .auth-footer a { color: var(--text-dark); text-decoration: none; font-weight: 500; border-bottom: 1px solid var(--text-dark); padding-bottom: 1px; transition: 0.2s; }
        .auth-footer a:hover { color: var(--brand-green); border-color: var(--brand-green); }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-logo">
            <img src="${pageContext.request.contextPath}/images/catfein_logo.png" alt="Catfeine Logo">
        </div>
        <div class="auth-header">
            <h2>Khôi Phục Mật Khẩu</h2>
            <p>Vui lòng nhập địa chỉ email bạn đã đăng ký để nhận mã xác thực OTP.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
            </div>
            <button type="submit" class="btn-submit">Gửi mã OTP</button>
        </form>

        <div class="auth-footer">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </div>
    </div>
</body>
</html>