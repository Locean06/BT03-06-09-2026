package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.model.Product;

import java.util.List;

public class ProductDaoImpl implements ProductDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ServletCRUDMVCPU");

    @Override
    public void insert(Product product) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(product);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void edit(Product product) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(product);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Product product = em.find(Product.class, id);
            if (product != null) em.remove(product);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product get(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getAll() {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> getTop10() {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setMaxResults(10); 
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.id DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            
            int offset = (page - 1) * pageSize;
            query.setFirstResult(offset);
            query.setMaxResults(pageSize);
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public int countAll() {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Product p";
            Long count = (Long) em.createQuery(jpql).getSingleResult();
            return count.intValue();
        } finally {
            em.close();
        }
    }
}