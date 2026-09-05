<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} | Catfeine</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --bg-cream: #fcfbf9; --brand-green: #144d29; --text-dark: #111111; --text-muted: #767676; --border-light: #e5e5e5; }
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background-color: var(--bg-cream); color: var(--text-dark); -webkit-font-smoothing: antialiased; }
        
        .navbar { background: rgba(252, 251, 249, 0.95); padding: 10px 5%; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-light); position: sticky; top: 0; z-index: 100; }
        .nav-logo img { height: 60px; transform: scale(2.0); transform-origin: left center; object-fit: contain; mix-blend-mode: multiply; }
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { color: var(--text-dark); text-decoration: none; font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 1.5px; position: relative; transition: 0.3s; }
        

        .container { max-width: 1100px; margin: 60px auto; padding: 0 5%; display: flex; gap: 60px; align-items: flex-start; }
        
        .detail-image { flex: 1; position: sticky; top: 100px; }
        .detail-image img { width: 100%; border-radius: 8px; object-fit: cover; }
        
        .detail-info { flex: 1; padding: 20px 0; }
        .breadcrumb { font-size: 12px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 20px; }
        .breadcrumb a { color: var(--text-muted); text-decoration: none; }
        .breadcrumb a:hover { color: var(--text-dark); }
        
        .product-title { font-size: 32px; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; color: var(--text-dark); }
        .product-price { font-size: 22px; font-weight: 600; color: var(--brand-green); margin-bottom: 30px; }
        
        .product-desc { font-size: 15px; line-height: 1.8; color: var(--text-muted); margin-bottom: 40px; padding-top: 30px; border-top: 1px solid var(--border-light); }
        
        .btn-add-cart { width: 100%; padding: 18px; background: var(--text-dark); color: var(--bg-cream); text-align: center; text-decoration: none; font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 2px; border: 1px solid var(--text-dark); cursor: pointer; transition: 0.3s; margin-bottom: 15px; }
        .btn-add-cart:hover { background: var(--brand-green); border-color: var(--brand-green); }
        
        .footer { border-top: 1px solid var(--border-light); padding: 50px 5%; text-align: center; margin-top: 100px; }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="nav-logo"><a href="<c:url value='/home'/>"><img src="<c:url value='/images/catfein_logo.png'/>" alt="Logo"></a></div>
        <div class="nav-links">
            <a href="<c:url value='/home'/>">New Arrivals</a>
            <a href="<c:url value='/product'/>">Collections</a>
            <a href="<c:url value='/home'/>">Back Home</a>
        </div>
    </div>

    <div class="container">
        <div class="detail-image">
            <c:choose>
                <c:when test="${not empty product.image}">
                    <img src="<c:url value='/image?fname=${product.image}'/>" alt="${product.name}">
                </c:when>
                <c:otherwise>
                    <img src="https://via.placeholder.com/600x800/ececec/999?text=No+Image" alt="No Image">
                </c:otherwise>
            </c:choose>
        </div>

        <!-- CỘT PHẢI: THÔNG TIN SẢN PHẨM -->
        <div class="detail-info">
            <div class="breadcrumb">
                <a href="<c:url value='/home'/>">Home</a> / <a href="<c:url value='/product'/>">${product.category.name}</a>
            </div>
            
            <h1 class="product-title">${product.name}</h1>
            <div class="product-price"><fmt:formatNumber value="${product.price}" pattern="#,###"/> ₫</div>
            
            <button class="btn-add-cart">Thêm vào giỏ hàng</button>

            <div class="product-desc">
                ${not empty product.description ? product.description : 'Sản phẩm thiết kế tối giản, tập trung vào chất liệu cao cấp và sự thoải mái cho người mặc.'}
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2026 Catfeine Minimalist Apparel.</p>
    </div>

</body>
</html>