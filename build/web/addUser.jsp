<%-- 
    Document   : addUser
    Created on : 10 Aug, 2024, 11:37:04 PM
    Author     : Nirmala
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration page </title>
         <link rel="stylesheet" type="text/css" href="style.css" />
   
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    </head>
    <body>
	
<div class="container">
      <h2>Enter your Profile: </h2>
      
      <form action="RegistrationChecker" Method="Post">
     
      <div class="form-container">

  <div class="input-name">
    <i class="fa fa-user lock"></i>
    <input type="text" placeholder="Enter Username" class="text-name" id="username" name="username"/>
  </div>


  
  <div class="input-name">
    <i class="fa fa-user lock"></i>
    <input type="text" placeholder="Enter Your Age" class="text-name" id="age" name="age" />
  </div>
          
          
  <div class="input-name">
    <Button type="submit" class="button" value="submit" id="submitbutton">Submit</Button>
  </div>
          
  </div>
</div>
          
 </form>
	
	<% 
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String username = request.getParameter("username");
                    int age = Integer.parseInt(request.getParameter("age"));
           
            %>
                    <div class="success-message">
                        <p>Registration successful! Welcome, <%= username %>!</p>
                    </div>
                    <script>
                        setTimeout(function() {
                            window.location.href = 'index.jsp';
                        }, 3000); 
                    </script>
            <%
                }
            %>

    </body>
</html>
