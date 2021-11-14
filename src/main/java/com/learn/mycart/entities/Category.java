/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.entities;

/**
 *
 * @author HP
 */
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
@Entity
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryId;
    private String categoryTittle;
    @Column(length=5000)
    private String categoryDescription;
    @OneToMany(mappedBy="category")
    private List<Product> products=new ArrayList<>();

   

    public Category(String categoryTittle, String categoryDescription, List<Product> products) {
        this.categoryTittle = categoryTittle;
        
        this.categoryDescription = categoryDescription;
        this.products=products;
    }

    public Category() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryTittle() {
        return categoryTittle;
    }

    public void setCategoryTittle(String categoryTittle) {
        this.categoryTittle = categoryTittle;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", categoryTittle=" + categoryTittle + ", categoryDescription=" + categoryDescription + '}';
    }
    
}
