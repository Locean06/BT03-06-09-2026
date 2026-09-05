<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm | Catfeine Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg-light: #f3f4f6; --brand-green: #144d29; --brand-hover: #0e3b1f; --text-main: #1f2937; --text-muted: #6b7280; --border: #e5e7eb; --sidebar-w: 240px; }
        * { box-sizing: border-box; font-family: 'Montserrat', sans-serif; margin: 0; padding: 0; }
        body { background: var(--bg-light); color: var(--text-main); display: flex; min-height: 100vh; }
        
        .sidebar { width: var(--sidebar-w); background: #ffffff; border-right: 1px solid var(--border); display: flex; flex-direction: column; flex-shrink: 0; position: sticky; top: 0; height: 100vh; }
        .logo-area { padding: 25px 20px; text-align: center; border-bottom: 1px solid var(--border); }
        .logo-area img { height: 60px; object-fit: contain; }
        
        .nav-menu { padding: 15px 0; list-style: none; flex: 1; }
        .menu-label { padding: 15px 25px 8px; font-size: 11px; font-weight: 700; color: #9ca3af; text-transform: uppercase; letter-spacing: 1.5px; }
        .nav-menu a { display: flex; align-items: center; gap: 10px; padding: 10px 25px; color: var(--text-main); text-decoration: none; font-size: 14px; font-weight: 500; transition: 0.2s; border-left: 3px solid transparent; }
        .nav-menu a:hover { background: #f9fafb; color: var(--brand-green); }
        .nav-menu a.active { color: var(--brand-green); background: #f0fdf4; border-left-color: var(--brand-green); font-weight: 600; }
        
        .sidebar-footer { padding: 20px; border-top: 1px solid var(--border); }
        .sidebar-footer a { color: #dc2626; text-decoration: none; font-size: 13px; font-weight: 600; display: flex; align-items: center; justify-content: center; gap: 8px; }

        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .top-bar { display: flex; justify-content: flex-end; margin-bottom: 25px; }
        .top-bar a { text-decoration: none; color: var(--text-main); font-size: 13px; font-weight: 600; padding: 8px 16px; border: 1px solid var(--border); border-radius: 6px; background: #fff; transition: 0.2s; }
        .top-bar a:hover { background: #f9fafb; }
        
        .grid-layout { display: flex; gap: 30px; align-items: flex-start; }
        
        .form-section { width: 360px; flex-shrink: 0; background: #fff; border-radius: 8px; border: 1px solid var(--border); padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); position: sticky; top: 30px; }
        .section-title { font-size: 16px; font-weight: 600; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--border); color: var(--brand-green); display: flex; justify-content: space-between; align-items: center;}
        
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: var(--text-main); }
        .form-control, .form-select { width: 100%; padding: 9px 12px; border: 1px solid var(--border); border-radius: 6px; font-size: 13px; background: #fff; outline: none; transition: 0.2s; }
        .form-control:focus, .form-select:focus { border-color: var(--brand-green); box-shadow: 0 0 0 3px rgba(20, 77, 41, 0.1); }
        textarea.form-control { height: 90px; resize: vertical; }
        
        .img-preview { margin-top: 10px; padding: 10px; border: 1px dashed var(--border); background: #f9fafb; border-radius: 6px; display: inline-block; }
        .img-preview img { width: 70px; height: 70px; object-fit: cover; border-radius: 6px; border: 1px solid var(--border); display: block; }
        
        .btn-submit { width: 100%; background: var(--brand-green); color: #fff; padding: 11px; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; transition: 0.2s; margin-bottom: 10px; }
        .btn-submit:hover { background: var(--brand-hover); }
        .btn-cancel { display: block; width: 100%; text-align: center; text-decoration: none; padding: 10px; border: 1px solid var(--border); border-radius: 6px; color: var(--text-main); font-size: 13px; font-weight: 600; transition: 0.2s; }
        .btn-cancel:hover { background: var(--bg-light); }

        .table-section { flex: 1; background: #fff; border-radius: 8px; border: 1px solid var(--border); padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid var(--border); }
        th { background: #f9fafb; font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px; }
        td { font-size: 13px; vertical-align: middle; }
        tr:hover td { background: #f9fafb; }
        
        tr.active-row td { background-color: #f0fdf4 !important; }

        .img-thumb { width: 45px; height: 45px; object-fit: cover; border-radius: 6px; border: 1px solid var(--border); }
        .action-link { text-decoration: none; font-size: 12px; font-weight: 600; padding: 6px 10px; border-radius: 4px; border: 1px solid var(--border); color: var(--text-main); margin-right: 4px; transition: 0.2s; display: inline-block;}
        .action-link:hover { background: var(--bg-light); }
        .text-danger { color: #dc2626; }
        .text-danger:hover { background: #fef2f2; border-color: #fca5a5; }
        .badge-cat { background: #e0e7ff; color: #3730a3; padding: 3px 8px; border-radius: 20px; font-size: 11px; font-weight: 600; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo-area"><img src="${pageContext.request.contextPath}/images/catfein_logo.png" alt="Logo"></div>
    <ul class="nav-menu">
        <li class="menu-label">Tổng quan</li>
        <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
        <li class="menu-label">Kho Cửa Hàng</li>
        <li><a href="${pageContext.request.contextPath}/admin/category/list">📁 Quản lý Danh mục</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product/list" class="active">🏷️ Quản lý Sản phẩm</a></li>
        <li class="menu-label">Hệ thống</li>
        <li><a href="${pageContext.request.contextPath}/admin/user/list">👥 Tài khoản</a></li>
    </ul>
    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a></div>
</div>

<div class="main-content">
    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/home">← Xem Cửa hàng</a>
    </div>

    <div class="grid-layout">
        <!-- CỘT 1: FORM THÊM / SỬA -->
        <div class="form-section">
            <div class="section-title">
                ${not empty product ? '🛠️ Chỉnh Sửa Sản Phẩm' : '✨ Thêm Sản Phẩm Mới'}
            </div>
            
            <form action="${pageContext.request.contextPath}/admin/product/${not empty product ? 'edit' : 'add'}" method="post" enctype="multipart/form-data">
                <c:if test="${not empty product}">
                    <input type="hidden" name="id" value="${product.id}">
                </c:if>

                <div class="form-group">
                    <label>Tên sản phẩm *</label>
                    <input type="text" name="name" value="${product.name}" class="form-control" required placeholder="Nhập tên sản phẩm...">
                </div>

                <div style="display: flex; gap: 15px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Giá bán (VNĐ) *</label>
                        <input type="number" name="price" value="${not empty product ? product.price.intValue() : ''}" class="form-control" required placeholder="0">
                    </div>

                    <div class="form-group" style="flex: 1;">
                        <label>Danh mục *</label>
                        <select name="category_id" class="form-select" required>
                            <option value="">-- Chọn --</option>
                            <c:forEach items="${cateList}" var="cate">
                                <option value="${cate.id}" ${product.category.id == cate.id ? 'selected' : ''}>${cate.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Mô tả chi tiết</label>
                    <textarea name="description" class="form-control" placeholder="Mô tả sản phẩm...">${product.description}</textarea>
                </div>

                <div class="form-group">
                    <label>Ảnh sản phẩm</label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                    <c:if test="${not empty product.image}">
                        <div class="img-preview">
                            <span style="display:block; font-size:11px; margin-bottom:5px; font-weight:600; color:var(--text-muted)">Ảnh hiện tại:</span>
                            <c:url value="/image" var="imgUrl"><c:param name="fname" value="${product.image}"/></c:url>
                            <img src="${imgUrl}" alt="product">
                        </div>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">${not empty product ? 'Lưu Thay Đổi' : 'Tạo Sản Phẩm'}</button>
                <c:if test="${not empty product}">
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn-cancel">Hủy Chỉnh Sửa</a>
                </c:if>
            </form>
        </div>

        <!-- CỘT 2: DANH SÁCH -->
        <div class="table-section">
            <div class="section-title" style="color: var(--text-main); border: none; padding: 0; display: flex; justify-content: space-between;">
                Danh sách dữ liệu
                <form action="${pageContext.request.contextPath}/admin/product/list" method="get" style="margin:0;">
                    <select name="categoryId" class="form-control" style="width: 180px; padding: 6px 10px;" onchange="this.form.submit()">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach items="${cateList}" var="cate">
                            <option value="${cate.id}" ${param.categoryId == cate.id ? 'selected' : ''}>${cate.name}</option>
                        </c:forEach>
                    </select>
                </form>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th width="50">ID</th>
                        <th width="60">Ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Giá bán</th>
                        <th width="120">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${productList}" var="prod">
                        <tr class="${prod.id == product.id ? 'active-row' : ''}">
                            <td>#${prod.id}</td>
                            <td>
                                <c:if test="${not empty prod.image}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${prod.image}" class="img-thumb" alt="Ảnh">
                                </c:if>
                            </td>
                            <td style="font-weight: 600;">${prod.name}</td>
                            <td><span class="badge-cat">${prod.category.name}</span></td>
                            <td style="font-weight: 700; color: var(--brand-green);">${prod.price} ₫</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/product/list?action=edit&id=${prod.id}" class="action-link">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${prod.id}" class="action-link text-danger" onclick="return confirm('Xóa sản phẩm này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>