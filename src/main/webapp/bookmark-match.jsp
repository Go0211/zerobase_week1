<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String insertQuery = "INSERT INTO bookmark (" +
            "bookmark_name," +
            "wifi_num," +
            "input_date)" +
            " VALUES (?, ?, ?)";
    if (conn != null) {
        try {
            request.setCharacterEncoding("UTF-8");
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, request.getParameter("bookmark_group_name"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("num")));
            pstmt.setString(3, String.valueOf(LocalDateTime.now()));
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("detail.jsp?num="+request.getParameter("num"));
%>

