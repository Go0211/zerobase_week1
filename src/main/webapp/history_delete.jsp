<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    String query = "delete from location_history where num = " + request.getParameter("num");

    try {
        stmt = conn.createStatement();
        int rowsAffected = stmt.executeUpdate(query);
        System.out.println(rowsAffected + "삭제");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("/history.jsp");
%>