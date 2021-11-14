/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import com.learn.mycart.entities.User;
import java.util.List;
import org.hibernate.Query;


import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author HP
 */
public class UserDao {
    public SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        try{
            String query="from User where userEmail =: e and userPassword =: p";
           Session session =this.factory.openSession();
           Query q=session.createQuery(query);
           q.setParameter("e",email);
           q.setParameter("p",password);
           user=(User) q.uniqueResult();
           session.close();
        }catch(Exception e){
            e.printStackTrace();
        }
       
        return user;
    }
     public List<User> getAllUser(){
     Session session=factory.openSession();
     org.hibernate.query.Query query=session.createQuery("from User");
     List<User> list=query.list();
     return list;
 }
 
}
