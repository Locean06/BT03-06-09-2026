package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = { 
    "/admin/category", 
    "/admin/category/list", 
    "/admin/category/add", 
    "/admin/category/edit", 
    "/admin/category/delete" 
})
@MultipartConfig
public class AdminCategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.endsWith("/admin/category") || url.contains("list")) {
            String action = req.getParameter("action");
            
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateService.get(id);
                req.setAttribute("category", category);
            }
            
            List<Category> cateList = cateService.getAll();
            req.setAttribute("cateList", cateList);
            req.getRequestDispatcher("/views/admin/category.jsp").forward(req, resp);
        } 
        else if (url.contains("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            cateService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("add") || url.contains("edit")) {
            String name = req.getParameter("name");
            Part iconPart = req.getPart("icon");
            String iconPath = null;

            if (iconPart != null && iconPart.getSize() > 0 && iconPart.getSubmittedFileName() != null && !iconPart.getSubmittedFileName().isBlank()) {
                String originalName = new File(iconPart.getSubmittedFileName()).getName();
                String extension = originalName.lastIndexOf('.') >= 0 ? originalName.substring(originalName.lastIndexOf('.')) : "";
                String fileName = System.currentTimeMillis() + extension;
                
                File uploadDir = new File(Constant.DIR, "category");
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                File file = new File(uploadDir, fileName);
                iconPart.write(file.getAbsolutePath());
                iconPath = "category/" + fileName;
            }

            Category category = new Category();
            category.setName(name);

            if (url.contains("edit")) {
                int id = Integer.parseInt(req.getParameter("id"));
                Category oldCate = cateService.get(id); // Lấy data cũ
                category.setId(id);
                category.setIcon(iconPath != null ? iconPath : oldCate.getIcon()); // Không up ảnh mới thì xài ảnh cũ
                cateService.edit(category);
            } else {
                category.setIcon(iconPath);
                cateService.insert(category);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
        }
    }
}