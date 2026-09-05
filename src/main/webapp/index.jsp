<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catfeine | Minimalist Essentials</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #fcfbf9;
            --brand-green: #144d29;
            --text-dark: #111111;
            --text-muted: #767676;
            --border-light: #e5e5e5;
        }

        /* 1. Thêm scroll-behavior: smooth để cuộn mượt mà */
        html { scroll-behavior: smooth; }
        
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background-color: var(--bg-cream); color: var(--text-dark); -webkit-font-smoothing: antialiased; }
        
        .navbar { background: rgba(252, 251, 249, 0.95); padding: 10px 5%; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-light); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        
       .nav-logo img { 
            height: 60px;
            transform: scale(2.0);
            transform-origin: left center;
            object-fit: contain; 
            mix-blend-mode: multiply;
        }
        
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { color: var(--text-dark); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 1.5px; position: relative; transition: 0.3s; }
        .nav-links a::after { content: ''; position: absolute; width: 0; height: 1px; bottom: -4px; left: 0; background-color: var(--text-dark); transition: width 0.3s; }
        .nav-links a:hover::after { width: 100%; }

        .nav-auth { display: flex; gap: 15px; align-items: center; }
        .nav-auth a { text-decoration: none; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; padding: 10px 20px; transition: 0.3s; border: 1px solid transparent; }
        
        .btn-login { color: var(--text-dark); border: 1px solid transparent; }
        .btn-login:hover { color: var(--brand-green); border-color: var(--border-light); }
        .btn-register { background: var(--text-dark); color: var(--bg-cream); }
        .btn-register:hover { background: var(--brand-green); color: var(--bg-cream); }
        
        .user-greeting { font-size: 12px; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted); padding-right: 15px; border-right: 1px solid var(--border-light); }
        .user-greeting span { color: var(--text-dark); font-weight: 600; }

        .hero { 
            padding: 120px 5%; 
            text-align: center; 
            border-bottom: 1px solid var(--border-light); 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            background: var(--bg-cream);
        }
        .hero h1 { font-size: 46px; font-weight: 500; color: var(--brand-green); margin-bottom: 15px; text-transform: uppercase; letter-spacing: 4px; }
        .hero p { font-size: 15px; color: var(--text-muted); max-width: 550px; margin: 0 auto 40px; line-height: 1.7; letter-spacing: 0.5px; font-weight: 400; }
        .btn-shop-now { border: 1px solid var(--text-dark); color: var(--text-dark); padding: 14px 35px; text-decoration: none; font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 2px; transition: all 0.3s; background: transparent; }
        .btn-shop-now:hover { background: var(--text-dark); color: var(--bg-cream); }

        .container { max-width: 1300px; margin: 80px auto; padding: 0 5%; }
        .section-header { text-align: center; margin-bottom: 60px; }
        .section-title { font-size: 20px; font-weight: 500; text-transform: uppercase; letter-spacing: 3px; color: var(--text-dark); margin-bottom: 12px; }
        
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 40px 20px; }
        
        .product-card { display: flex; flex-direction: column; cursor: pointer; }
        .product-img-wrapper { width: 100%; aspect-ratio: 3 / 4; background: #f3f4f6; overflow: hidden; margin-bottom: 15px; position: relative; border-radius: 4px; }
        
        .product-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; }
        .product-card:hover .product-img { transform: scale(1.05); }
        
        .product-overlay { position: absolute; bottom: 0; left: 0; right: 0; background: rgba(255, 255, 255, 0.95); padding: 12px; text-align: center; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; transform: translateY(100%); transition: transform 0.3s ease; color: var(--brand-green); }
        .product-card:hover .product-overlay { transform: translateY(0); }
        
        .product-info { text-align: center; padding: 0 10px; }
        .product-cate { font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; font-weight: 500; }
        .product-name { font-size: 14px; color: var(--text-dark); font-weight: 500; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; transition: 0.2s; }
        .product-card:hover .product-name { color: var(--brand-green); }
        
        .product-price { font-size: 14px; color: var(--text-dark); font-weight: 600; }

        .product-link { text-decoration: none; color: inherit; display: block; }

        .footer { border-top: 1px solid var(--border-light); padding: 50px 5%; text-align: center; margin-top: 100px; }
        .footer-logo { height: 90px; opacity: 0.7; margin-bottom: 20px; mix-blend-mode: multiply; }
        .footer p { font-size: 12px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; font-weight: 500; }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="nav-logo">
            <a href="<c:url value='/home'/>">
                <img src="<c:url value='/images/catfein_logo.png'/>" alt="Catfeine Logo">
            </a>
        </div>
        <div class="nav-links">
            <a href="<c:url value='/home'/>">New Arrivals</a>
            <a href="<c:url value='/product'/>">Collections</a>
            <a href="#">About</a>
        </div>
        
        <div class="nav-auth">
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <div class="user-greeting">
                        Hi, <span>${not empty sessionScope.account.fullName ? sessionScope.account.fullName : 'Thành viên'}</span>
                    </div>
                    
                    <c:if test="${sessionScope.account.role == 1}">
                        <a href="<c:url value='/admin/category/list'/>" class="btn-login" style="color: var(--brand-green);">Workspace</a>
                    </c:if>
                    
                    <a href="<c:url value='/logout'/>" class="btn-login">Log Out</a>
                </c:when>
                
                <c:otherwise>
                    <a href="<c:url value='/login'/>" class="btn-login">Log In</a>
                    <a href="<c:url value='/register'/>" class="btn-register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="hero">
        <h1>Essential. Minimal.</h1>
        <p>Định hình phong cách cá nhân với những thiết kế tối giản, tinh tế và tập trung vào chất liệu cao cấp cho mùa thu đông 2026.</p>
        <!-- 2. Trỏ href về thẻ id #collection -->
        <a href="#collection" class="btn-shop-now">Khám phá bộ sưu tập</a>
    </div>

    <!-- 3. Gắn id="collection" vào khu vực muốn cuộn tới -->
    <div class="container" id="collection">
        <div class="section-header">
            <h2 class="section-title">New Arrivals</h2>
            <a href="<c:url value='/product'/>" style="font-size: 13px; color: var(--brand-green); text-decoration: none; border-bottom: 1px solid var(--brand-green); padding-bottom: 2px; font-weight: 500;">Xem toàn bộ</a>
        </div>

        <div class="product-grid">
            <c:forEach var="item" items="${top10Products}">
                <div class="product-card">
                    <a href="<c:url value='/product/detail?id=${item.id}'/>" class="product-link">
                        <div class="product-img-wrapper">
                            <c:choose>
                                <c:when test="${not empty item.image}">
                                    <img src="<c:url value='/image?fname=${item.image}'/>" class="product-img" alt="${item.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300x400/ececec/999?text=No+Image" class="product-img" alt="No Image">
                                </c:otherwise>
                            </c:choose>
                            <div class="product-overlay">Xem Chi Tiết</div>
                        </div>

                        <div class="product-info">
                            <div class="product-cate">${item.category.name}</div>
                            <div class="product-name">${item.name}</div>
                            <div class="product-price">
                                <fmt:formatNumber value="${item.price}" pattern="#,###"/> ₫
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="footer">
        <img src="<c:url value='/images/catfein_logo.png'/>" alt="Catfeine" class="footer-logo">
        <p>&copy; 2026 Catfeine Minimalist Apparel.</p>
    </div>

</body>
</html>