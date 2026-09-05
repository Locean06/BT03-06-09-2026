package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
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
            if (url.contains("edit")) {
                int id = Integer.parseInt(req.getParameter("id"));
                product = productService.get(id); 
            }

            product.setName(name);
            product.setPrice(price);
            product.setDescription(description);
            Category category = categoryService.get(categoryId); 
            product.setCategory(category);

            try {
                Part part = req.getPart("image");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    
                    part.write(uploadPath + File.separator + filename);
                    product.setImage(filename);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (url.contains("add")) {
                productService.insert(product);
            } else {
                productService.edit(product);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }
}