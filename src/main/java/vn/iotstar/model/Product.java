package vn.iotstar.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Product")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private int id;

    @Column(name = "product_name", nullable = false, length = 255)
    private String name;

    @Column(name = "price")
    private double price;

    @Column(name = "image", length = 255)
    private String image;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    // Quan hệ N-1 với Category
    @ManyToOne
    @JoinColumn(name = "cate_id")
    private Category category;

    public Product() {}

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}