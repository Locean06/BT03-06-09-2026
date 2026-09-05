<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Collections | Catfeine</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { 
            --bg-cream: #fcfbf9; 
            --brand-green: #144d29; 
            --text-dark: #111111; 
            --text-muted: #767676; 
            --border-light: #e5e5e5; 
        }
        
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background-color: var(--bg-cream); color: var(--text-dark); -webkit-font-smoothing: antialiased; }
        
        .navbar { background: rgba(252, 251, 249, 0.95); padding: 10px 5%; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-light); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .nav-logo img { height: 60px; transform: scale(2.0); transform-origin: left center; object-fit: contain; mix-blend-mode: multiply; }
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { color: var(--text-dark); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 1.5px; position: relative; transition: 0.3s; }
        .nav-links a::after { content: ''; position: absolute; width: 0; height: 1px; bottom: -4px; left: 0; background-color: var(--text-dark); transition: width 0.3s; }
        .nav-links a:hover::after { width: 100%; }
        
        .nav-auth { display: flex; gap: 15px; align-items: center; }
        .nav-auth a { text-decoration: none; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; padding: 10px 20px; transition: 0.3s; border: 1px solid transparent; }
        .btn-login { color: var(--text-dark); }
        .btn-login:hover { color: var(--brand-green); border-color: var(--border-light); }
        .btn-register { background: var(--text-dark); color: var(--bg-cream); }
        .btn-register:hover { background: var(--brand-green); color: var(--bg-cream); }
        
        .user-greeting { font-size: 12px; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted); padding-right: 15px; border-right: 1px solid var(--border-light); }
        .user-greeting span { color: var(--text-dark); font-weight: 600; }

        .container { max-width: 1300px; margin: 60px auto; padding: 0 5%; min-height: 50vh; }
        .page-title { text-align: center; font-size: 24px; font-weight: 500; text-transform: uppercase; letter-spacing: 3px; margin-bottom: 50px; }
        
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 50px 30px; }
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

        .pagination { display: flex; justify-content: center; align-items: center; gap: 10px; margin-top: 60px; }
        .pagination a { text-decoration: none; padding: 10px 16px; border: 1px solid var(--border-light); color: var(--text-dark); font-size: 13px; font-weight: 600; transition: 0.3s; border-radius: 4px; }
        .pagination a:hover { border-color: var(--text-dark); }
        .pagination a.active { background: var(--text-dark); color: var(--bg-cream); border-color: var(--text-dark); }
        
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
            <a href="<c:url value='/home#collection'/>">New Arrivals</a>
            <a href="<c:url value='/product'/>" style="border-bottom: 1px solid var(--text-dark);">Collections</a>
            <a href="#">About</a>
        </div>
        <div class="nav-auth">
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <div class="user-greeting">Hi, <span>${sessionScope.account.fullName}</span></div>
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

    <div class="container">
        <h1 class="page-title">All Collections</h1>
        
        <div class="product-grid">
            <c:forEach var="item" items="${productList}">
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

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="<c:url value='/product?page=${currentPage - 1}'/>">«</a>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="<c:url value='/product?page=${i}'/>" class="${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="<c:url value='/product?page=${currentPage + 1}'/>">»</a>
                </c:if>
            </div>
        </c:if>
    </div>
    <div class="footer">
        <img src="<c:url value='/images/catfein_logo.png'/>" alt="Catfeine" class="footer-logo">
        <p>&copy; 2026 Catfeine Minimalist Apparel.</p>
    </div>

</body>
</html>