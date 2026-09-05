package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = { 
    "/admin/product", 
    "/admin/product/list", 
    "/admin/product/add", 
    "/admin/product/edit", 
    "/admin/product/delete" 
})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl(); 

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.endsWith("/admin/product") || url.contains("list")) {
            String action = req.getParameter("action");
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.get(id);
                req.setAttribute("product", product);
            }
            
            List<Category> cateList = categoryService.getAll();
            req.setAttribute("cateList", cateList);

            List<Product> productList = productService.getAll();
            String categoryIdParam = req.getParameter("categoryId");
            
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                int catId = Integer.parseInt(categoryIdParam);
                productList = productList.stream()
                        .filter(p -> p.getCategory().getId() == catId)
                        .collect(Collectors.toList());
            }
            req.setAttribute("productList", productList);
            
            req.getRequestDispatcher("/views/admin/product.jsp").forward(req, resp);
        } 
        else if (url.contains("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("add") || url.contains("edit")) {
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int categoryId = Integer.parseInt(req.getParameter("category_id"));

            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setDescription(description);
            Category category = categoryService.get(categoryId); 
            product.setCategory(category);

            Part part = req.getPart("image");
            String imagePath = null;
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isBlank()) {
                String originalName = new File(part.getSubmittedFileName()).getName();
                String extension = originalName.lastIndexOf('.') >= 0 ? originalName.substring(originalName.lastIndexOf('.')) : "";
                String fileName = System.currentTimeMillis() + extension;
                
                File uploadDir = new File(Constant.DIR, "product");
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                File file = new File(uploadDir, fileName);
                part.write(file.getAbsolutePath());
                imagePath = "product/" + fileName;
            }

            if (url.contains("edit")) {
                int id = Integer.parseInt(req.getParameter("id"));
                Product oldProduct = productService.get(id);
                product.setId(id);
                product.setImage(imagePath != null ? imagePath : oldProduct.getImage());
                productService.edit(product);
            } else {
                product.setImage(imagePath);
                productService.insert(product);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }
}