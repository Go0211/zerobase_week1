<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    String query = "delete from bookmark where id = " + request.getParameter("num");

    try {
        stmt = conn.createStatement();
        int rowsAffected = stmt.executeUpdate(query);
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

    response.sendRedirect("/bookmark-list.jsp");
%>
