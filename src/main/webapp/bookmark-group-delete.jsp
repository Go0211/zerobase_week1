<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String deleteQuery = "DELETE from bookmark_group " +
            "where id = " + request.getParameter("num");
    if (conn != null) {
        try {
            pstmt = conn.prepareStatement(deleteQuery);
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("bookmark-group.jsp");
%>

