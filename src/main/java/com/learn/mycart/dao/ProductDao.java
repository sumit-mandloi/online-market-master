/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

/**
 *
 * @author HP
 */
public class ProductDao {
 private SessionFactory factory; 

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
 public boolean saveProduct(Product product){
     boolean f=false;
       try{
        Session session=this.factory.openSession();
        Transaction tr=session.beginTransaction();
        int id=(int)session.save(product);
        session.save(product);
        tr.commit();
        session.close();
        f=true;
       }catch(Exception e){
           e.printStackTrace();
           f=false;
       }
        
        return f;
 }
 
 public List<Product> getAllProduct(){
     Session session=factory.openSession();
     Query query=session.createQuery("from Product");
     List<Product> list=query.list();
     return list;
 }
 
 
  public List<Product> getAllProductById(int cid){
     Session session=factory.openSession();
     Query query=session.createQuery("from Product as p where p.category.categoryId =: id ");
     query.setParameter("id", cid); 
     List<Product> list=query.list();
     return list;
 }
  
   public List searchByName(String name) {
        Session session=factory.openSession();
        Criteria criteria=session.createCriteria(Product.class);
        criteria.add(Restrictions.like("pName", "%"+name+"%"));
        List li=criteria.list();
        if(li.size() > 0){
            return li;
        }
       return null;
    }
}
