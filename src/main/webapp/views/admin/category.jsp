<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục | Catfeine Admin</title>
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
        
        .form-section { width: 340px; flex-shrink: 0; background: #fff; border-radius: 8px; border: 1px solid var(--border); padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); position: sticky; top: 30px; }
        .section-title { font-size: 16px; font-weight: 600; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--border); color: var(--brand-green); }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: var(--text-main); }
        .form-control { width: 100%; padding: 10px 14px; border: 1px solid var(--border); border-radius: 6px; font-size: 14px; background: #fff; outline: none; transition: 0.2s; }
        .form-control:focus { border-color: var(--brand-green); box-shadow: 0 0 0 3px rgba(20, 77, 41, 0.1); }
        
        .img-preview { margin-top: 10px; padding: 10px; border: 1px dashed var(--border); background: #f9fafb; border-radius: 6px; display: inline-block; }
        .img-preview img { width: 60px; height: 60px; object-fit: cover; border-radius: 6px; border: 1px solid var(--border); display: block; }
        
        .btn-submit { width: 100%; background: var(--brand-green); color: #fff; padding: 11px; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; transition: 0.2s; margin-bottom: 10px; }
        .btn-submit:hover { background: var(--brand-hover); }
        .btn-cancel { display: block; width: 100%; text-align: center; text-decoration: none; padding: 10px; border: 1px solid var(--border); border-radius: 6px; color: var(--text-main); font-size: 13px; font-weight: 600; transition: 0.2s; }
        .btn-cancel:hover { background: var(--bg-light); }

        .table-section { flex: 1; background: #fff; border-radius: 8px; border: 1px solid var(--border); padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid var(--border); }
        th { background: #f9fafb; font-size: 12px; color: var(--text-muted); text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px; }
        td { font-size: 14px; vertical-align: middle; }
        tr:hover td { background: #f9fafb; }
        
        tr.active-row td { background-color: #f0fdf4 !important; }

        .img-thumb { width: 40px; height: 40px; object-fit: cover; border-radius: 6px; border: 1px solid var(--border); }
        .action-link { text-decoration: none; font-size: 12px; font-weight: 600; padding: 6px 10px; border-radius: 4px; border: 1px solid var(--border); color: var(--text-main); margin-right: 4px; transition: 0.2s; display: inline-block;}
        .action-link:hover { background: var(--bg-light); }
        .text-danger { color: #dc2626; }
        .text-danger:hover { background: #fef2f2; border-color: #fca5a5; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo-area"><img src="${pageContext.request.contextPath}/images/catfein_logo.png" alt="Logo"></div>
    <ul class="nav-menu">
        <li class="menu-label">Tổng quan</li>
        <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
        <li class="menu-label">Kho Cửa Hàng</li>
        <li><a href="${pageContext.request.contextPath}/admin/category/list" class="active">Quản lý Danh mục</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/product/list">Quản lý Sản phẩm</a></li>
        <li class="menu-label">Hệ thống</li>
        <li><a href="${pageContext.request.contextPath}/admin/user/list">Tài khoản</a></li>
    </ul>
    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div>
</div>

<div class="main-content">
    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/home">← Xem Cửa hàng</a>
    </div>

    <div class="grid-layout">
        <div class="form-section">
            <div class="section-title">
                ${not empty category ? 'Chỉnh Sửa Danh Mục' : 'Thêm Danh Mục Mới'}
            </div>
            
            <form action="${pageContext.request.contextPath}/admin/category/${not empty category ? 'edit' : 'add'}" method="post" enctype="multipart/form-data">
                <c:if test="${not empty category}">
                    <input type="hidden" name="id" value="${category.id}">
                </c:if>

                <div class="form-group">
                    <label>Tên danh mục *</label>
                    <input type="text" name="name" value="${category.name}" class="form-control" required placeholder="Ví dụ: Áo Polo...">
                </div>

                <div class="form-group">
                    <label>Ảnh biểu tượng (Icon)</label>
                    <input type="file" name="icon" class="form-control" accept="image/*" ${empty category ? '' : ''}>
                    
                    <c:if test="${not empty category.icon}">
                        <div class="img-preview">
                            <span style="display:block; font-size:11px; margin-bottom:5px; font-weight:600; color:var(--text-muted)">Ảnh hiện tại:</span>
                            <c:url value="/image" var="imgUrl"><c:param name="fname" value="${category.icon}"/></c:url>
                            <img src="${imgUrl}" alt="category">
                        </div>
                    </c:if>
                </div>

                <button type="submit" class="btn-submit">${not empty category ? 'Lưu Thay Đổi' : 'Tạo Danh Mục'}</button>
                <c:if test="${not empty category}">
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn-cancel">Hủy Chỉnh Sửa</a>
                </c:if>
            </form>
        </div>

        <div class="table-section">
            <div class="section-title" style="color: var(--text-main); border: none; padding: 0;">Danh sách dữ liệu</div>
            <table>
                <thead>
                    <tr>
                        <th width="60">ID</th>
                        <th width="70">Ảnh</th>
                        <th>Tên danh mục</th>
                        <th width="140">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cateList}" var="cate">
                        <tr class="${cate.id == category.id ? 'active-row' : ''}">
                            <td>#${cate.id}</td>
                            <td>
                                <c:if test="${not empty cate.icon}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${cate.icon}" class="img-thumb" alt="Icon">
                                </c:if>
                            </td>
                            <td style="font-weight: 600;">${cate.name}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/category/list?action=edit&id=${cate.id}" class="action-link">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" class="action-link text-danger" onclick="return confirm('Xóa danh mục này?')">Xóa</a>
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