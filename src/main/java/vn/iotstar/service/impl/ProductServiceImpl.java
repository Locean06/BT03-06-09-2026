package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.model.Product;
import vn.iotstar.service.ProductService;

public class ProductServiceImpl implements ProductService {

    private ProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) { productDao.insert(product); }

    @Override
    public void edit(Product product) { productDao.edit(product); }

    @Override
    public void delete(int id) { productDao.delete(id); }

    @Override
    public Product get(int id) { return productDao.get(id); }

    @Override
    public List<Product> getAll() { return productDao.getAll(); }

    @Override
    public List<Product> getTop10() { return productDao.getTop10(); }

    @Override
    public List<Product> findAll(int page, int pageSize) { return productDao.findAll(page, pageSize); }

    @Override
    public int countAll() { return productDao.countAll(); }
}