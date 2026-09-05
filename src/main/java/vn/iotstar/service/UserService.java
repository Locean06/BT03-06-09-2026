package vn.iotstar.service;

import vn.iotstar.model.User;

public interface UserService {
    void insert(User user);
    void update(User user);
    User findByEmail(String email);
}