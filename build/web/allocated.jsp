<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Seat Allocation Result</title>
    <link rel="stylesheet" type="text/css" href="allocate.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    
</head>
<body bgcolor="light gray">
    <div id="btn"><a href="index.jsp">Cancel</a></div>
    <div class="container">
<%
    String userLoginId = request.getParameter("userLoginId");
    int trainChoice = Integer.parseInt(request.getParameter("trainChoice"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trainallocationsystem", "root", "root");

        
        String userCheckQuery = "SELECT COUNT(*) FROM Users WHERE user_login_id = ?";
        pstmt = conn.prepareStatement(userCheckQuery);
        pstmt.setString(1, userLoginId);
        rs = pstmt.executeQuery();

        rs.next();
        int userExists = rs.getInt(1);

        if (userExists == 0) 
        {
            out.println("<h2>Error: The user_login_id " + userLoginId + " does not exist.</h2>");
        } 
        else {
            
            String seatQuery = "SELECT boogie_number, seat_number FROM TrainAllocations " +
                                "WHERE train_id = ? ORDER BY boogie_number, seat_number DESC LIMIT 1";
            pstmt = conn.prepareStatement(seatQuery);
            pstmt.setInt(1, trainChoice);
            rs = pstmt.executeQuery();

            int nextBoogie = 1;
            int nextSeat = 1;

            if (rs.next()) {
                int lastBoogie = rs.getInt("boogie_number");
                int lastSeat = rs.getInt("seat_number");

                if (lastSeat == 2) {
                    nextBoogie = lastBoogie + 1;
                    nextSeat = 1;
                } else {
                    nextBoogie = lastBoogie;
                    nextSeat = lastSeat + 1;
                }
            }

            if (nextBoogie > 3) 
            {
                out.println("<h2>Sorry, no available seats in Train " + trainChoice + ".</h2>");
            } 
            else {
                
                String insertSQL = "INSERT INTO TrainAllocations (train_id, boogie_number, seat_number, user_login_id) " +
                                   "VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertSQL);
                pstmt.setInt(1, trainChoice);
                pstmt.setInt(2, nextBoogie);
                pstmt.setInt(3, nextSeat);
                pstmt.setString(4, userLoginId);
                pstmt.executeUpdate();

                out.println("<h2>Seat successfully allocated:</h2>");
                out.println("<p>Train: " + trainChoice + "</p>");
                out.println("<p>Boogie: " + nextBoogie + "</p>");
                out.println("<p>Seat: " + nextSeat + "</p>");
            }
        }
    } catch (SQLException e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
    </div>
</body>
</html>
