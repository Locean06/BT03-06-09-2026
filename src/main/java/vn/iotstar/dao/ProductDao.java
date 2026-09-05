package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.Product;

public interface ProductDao {
    void insert(Product product);
    
    void edit(Product product);
    
    void delete(int id);
    
    Product get(int id);
    
    List<Product> getAll();
    List<Product> getTop10();
    List<Product> findAll(int page, int pageSize);
    int countAll(); 
}