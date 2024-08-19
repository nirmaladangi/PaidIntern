/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DTO.UserDTO;
import Model.RegistrationAuthenticator;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nirmala
 */
public class RegistrationChecker extends HttpServlet {
   
     public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
       response.sendRedirect("addUser.jsp");
    }
     
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
     {

       
       String username =request.getParameter("username");
       String age = request.getParameter("age");
       
       
       UserDTO emp= new UserDTO();
        
        emp.setUsername(username);
        emp.setAge(age);
        
       RegistrationAuthenticator authenticator = new RegistrationAuthenticator();
        boolean registration = authenticator.isRegistration(emp);
        
        
        if(registration)
          {
            HttpSession session =request.getSession(true); 
             session.setAttribute("username",username);
             session.setAttribute("age",age);
             response.sendRedirect("admin.jsp");
             
          }
          else
          {
             response.sendRedirect("addUser.jsp");
          }
        
       
    }

    
}
