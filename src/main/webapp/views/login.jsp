<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập | Catfeine</title>
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
        .auth-header p { color: var(--text-muted); font-size: 13px; margin-top: 8px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-dark); }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid var(--border-light); font-size: 14px; outline: none; transition: all 0.3s; background: transparent; }
        .form-control:focus { border-color: var(--brand-green); }

        .forgot-pass { display: block; text-align: right; font-size: 12px; margin-top: 8px; color: var(--text-muted); text-decoration: none; border: none !important; }
        .forgot-pass:hover { color: var(--text-dark); }

        .btn-submit { width: 100%; background: var(--text-dark); color: var(--bg-cream); border: 1px solid var(--text-dark); padding: 14px; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; cursor: pointer; transition: 0.3s; margin-top: 15px; }
        .btn-submit:hover { background: var(--brand-green); border-color: var(--brand-green); }

        .alert-error { background: #fff0f0; color: #d0021b; padding: 12px; font-size: 13px; margin-bottom: 20px; border: 1px solid #d0021b; text-align: center; }
        .alert-success { background: #f4fbf7; color: var(--brand-green); padding: 12px; font-size: 13px; margin-bottom: 20px; border: 1px solid var(--brand-green); text-align: center; }

        .auth-footer { text-align: center; margin-top: 25px; font-size: 13px; color: var(--text-muted); }
        .auth-footer a { color: var(--text-dark); text-decoration: none; font-weight: 500; border-bottom: 1px solid var(--text-dark); padding-bottom: 1px; transition: 0.2s; }
        .auth-footer a:hover { color: var(--brand-green); border-color: var(--brand-green); }
        .back-home { display: inline-block; margin-top: 20px; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; border: none !important; }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-logo">
            <img src="<c:url value='/images/catfein_logo.png'/>" alt="Catfeine Logo">
        </div>
        <div class="auth-header">
            <h2>Đăng Nhập</h2>
            <p>Chào mừng bạn trở lại</p>
        </div>

        <%-- KHU VỰC HIỂN THỊ THÔNG BÁO --%>
        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>
        
        <c:choose>
            <c:when test="${param.message == 'reset_success'}">
                <div class="alert-success">Đổi mật khẩu thành công. Vui lòng đăng nhập!</div>
            </c:when>
            <c:when test="${param.message == 'success'}">
                <div class="alert-success">Kích hoạt thành công. Vui lòng đăng nhập.</div>
            </c:when>
        </c:choose>

        <form action="<c:url value='/login'/>" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
                <a href="<c:url value='/forgot-password'/>" class="forgot-pass">Quên mật khẩu?</a>
            </div>
            <button type="submit" class="btn-submit">Đăng Nhập</button>
        </form>

        <div class="auth-footer">
            Chưa có tài khoản? <a href="<c:url value='/register'/>">Đăng ký ngay</a><br>
            <a href="<c:url value='/home'/>" class="back-home">Quay về Cửa hàng</a>
        </div>
    </div>
</body>
</html>