<%--
  Created by IntelliJ IDEA.
  User: rhtjd
  Date: 2024-03-04
  Time: 오후 5:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    String query = "INSERT INTO test VALUES (?)";
    if (conn != null) {
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, request.getParameter("id"));
            pstmt.executeUpdate();
            conn.close();
            pstmt.close();
%>
<script>
    alert("Insert 성공");
    location.href='insert_test.jsp';
</script>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    }

} else {
%>
<script>
    alert("Database 연결 실패");
    history.back();
</script>
<%

    }
%>
