package vn.iotstar.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Users")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "full_name", columnDefinition = "NVARCHAR(255)")
    private String fullName;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;
    
    @Column(name = "otp_code", length = 10)
    private String otpCode;

    @Column(name = "is_active")
    private boolean isActive;

    @Column(name = "role")
    private int role;

    public User() {}

    public User(String email, String password, String otpCode, boolean isActive) {
        this.email = email;
        this.password = password;
        this.otpCode = otpCode;
        this.isActive = isActive;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getOtpCode() { return otpCode; }
    public void setOtpCode(String otpCode) { this.otpCode = otpCode; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }
}