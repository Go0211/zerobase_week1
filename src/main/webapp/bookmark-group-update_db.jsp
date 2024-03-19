<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String insertQuery = "UPDATE bookmark_group " +
            "SET bookmark_name = ? ," +
            "seq = ? ," +
            "update_date = ?" +
            "where id = ?";

    if (conn != null) {
        try {
            request.setCharacterEncoding("UTF-8");
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("seq")));
            pstmt.setString(3, String.valueOf(LocalDateTime.now()));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("bookmark-group.jsp");
%>