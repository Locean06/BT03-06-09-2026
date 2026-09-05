package vn.iotstar.dao;

import vn.iotstar.model.User;

public interface UserDao {
    void insert(User user);
    void update(User user);
    User findByEmail(String email);
}