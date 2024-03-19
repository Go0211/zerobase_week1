<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String query = "INSERT INTO location_history ("
            + "x_coordinates,"
            + "y_coordinates,"
            + "view_date)"
            + "VALUES(?, ?, ?)";

    StringBuilder sb = new StringBuilder();
    BufferedReader requestData = request.getReader();
    String str = null;
    while ((str = requestData.readLine()) != null) {
        sb.append(str);
    }

    JSONObject jsonObject = new JSONObject(sb.toString());

    try {
        pstmt = conn.prepareStatement(query);
        pstmt.setDouble(1, jsonObject.getDouble("x_coordinates"));
        pstmt.setDouble(2, jsonObject.getDouble("y_coordinates"));
        pstmt.setString(3, String.valueOf(LocalDateTime.now()));
        pstmt.executeUpdate();
        pstmt.close();
    } catch (Exception e) {
        System.out.println(e);
        throw new RuntimeException(e);
    } finally {
        // 리소스 해제
        try {
            if (pstmt != null) pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

%>
