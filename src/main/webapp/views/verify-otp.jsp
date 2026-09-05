<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận OTP | Catfeine</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --bg-cream: #fcfbf9; --brand-green: #144d29; --text-dark: #111111; --text-muted: #767676; --border-light: #e5e5e5; }
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background-color: var(--bg-cream); display: flex; justify-content: center; align-items: center; min-height: 100vh; color: var(--text-dark); }
        
        .auth-container { background: #ffffff; width: 100%; max-width: 420px; padding: 50px 40px; border: 1px solid var(--border-light); text-align: center; }
        .auth-logo { margin-bottom: 25px; }
        .auth-logo img { height: 70px; object-fit: contain; }
        
        .auth-header h2 { font-size: 18px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 10px; }
        .auth-header p { color: var(--text-muted); font-size: 13px; line-height: 1.6; }
        .auth-header strong { color: var(--text-dark); font-weight: 500; }

        .form-group { margin: 30px 0 20px; text-align: left; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-dark); text-align: center; }
        .form-control { width: 100%; padding: 15px; border: 1px dashed var(--text-muted); font-size: 24px; font-weight: 500; text-align: center; letter-spacing: 8px; outline: none; transition: all 0.3s; background: transparent; }
        .form-control:focus { border-color: var(--brand-green); }

        .btn-submit { width: 100%; background: var(--text-dark); color: var(--bg-cream); border: 1px solid var(--text-dark); padding: 14px; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; cursor: pointer; transition: 0.3s; }
        .btn-submit:hover { background: var(--brand-green); border-color: var(--brand-green); }

        .alert-error { background: #fff0f0; color: #d0021b; padding: 12px; font-size: 13px; margin-bottom: 20px; border: 1px solid #d0021b; text-align: center; }

        .auth-footer { margin-top: 25px; font-size: 13px; color: var(--text-muted); }
        .auth-footer a { color: var(--text-dark); text-decoration: none; font-weight: 500; border-bottom: 1px solid var(--text-dark); padding-bottom: 1px; transition: 0.2s; }
        .auth-footer a:hover { color: var(--brand-green); border-color: var(--brand-green); }
        .back-home { display: inline-block; margin-top: 20px; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; border: none !important; }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-logo">
            <img src="${pageContext.request.contextPath}/images/catfein_logo.png" alt="Catfeine Logo">
        </div>
        <div class="auth-header">
            <h2>Xác Thực OTP</h2>
            <p>Mã bảo mật 6 số đã được gửi đến:<br><strong>${email}</strong></p>
        </div>

        <c:if test="${not empty error}"><div class="alert-error">${error}</div></c:if>

        <!-- DUY NHẤT 1 FORM Ở ĐÂY -->
        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <input type="hidden" name="email" value="${email}">
            <input type="hidden" name="action" value="${param.action}">
            <div class="form-group">
                <label>Nhập mã OTP</label>
                <input type="text" name="otp" class="form-control" required maxlength="6" autocomplete="off" placeholder="------">
            </div>
            <button type="submit" class="btn-submit">Xác Nhận</button>
        </form>

        <div class="auth-footer">
            Chưa nhận được mã? <a href="${pageContext.request.contextPath}/register">Gửi lại</a><br>
            <a href="${pageContext.request.contextPath}/home" class="back-home">Quay về Cửa hàng</a>
        </div>
    </div>
</body>
</html>