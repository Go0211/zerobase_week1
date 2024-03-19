<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String insertQuery = "INSERT INTO bookmark_group (" +
            "bookmark_name," +
            "seq," +
            "input_date)" +
            " VALUES (?, ?, ?)";
    if (conn != null) {
        try {
            request.setCharacterEncoding("UTF-8");
            System.out.println(request.getParameter("name"));

            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("seq"));
            pstmt.setString(3, String.valueOf(LocalDateTime.now()));
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("bookmark-group.jsp");
%>

