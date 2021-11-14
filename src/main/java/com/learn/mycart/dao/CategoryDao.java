/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author HP
 */
public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    public int saveCategory(Category category){
        Session session=this.factory.openSession();
        Transaction tr=session.beginTransaction();
        int id=(int)session.save(category);
        tr.commit();
        session.close();
        
        return id;
    }
    public List<Category> getCategories(){
        Session session=this.factory.openSession();
        Query query=session.createQuery("from Category");
        List<Category> list=query.list();
        return list;
    }
    public Category getCategoryById(int categoryId){
        Category category=null;
        try{
            Session session=this.factory.openSession();
            category=session.get(Category.class, categoryId);
            session.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return category;
    }
}
