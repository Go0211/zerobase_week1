<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.wifi.Bookmark" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    ResultSet rs = null;

    Integer bookmarkNum = null;
    String bookmarkName = null;
    String inputDate = null;

    try {
        String query = "SELECT * " +
                "from bookmark " +
                "where id = " + request.getParameter("id");
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        rs.next();

        bookmarkNum = rs.getInt("id");
        bookmarkName = rs.getString("bookmark_name");
        inputDate = rs.getString("input_date");

    } catch (SQLException e) {
        throw new RuntimeException(e);
    } finally {
        // 리소스 해제
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null) stmt.close();
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

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bookmark-delete.css">
    <title>Document</title>
</head>

<body>
    <h1>북마크 삭제</h1>
    <div>
        <span>
            <a href="index.jsp">홈</a>
        </span>
        <span> | </span>
        <span>
            <a href="history.jsp">위치 히스토리 목록</a>
        </span>
        <span> | </span>
        <span>
            <a href="wifi_data_insert.jsp">Open API 와이파이 정보 가져오기</a>
        </span>
        <span> | </span>
        <span>
            <a href="bookmark-list.jsp">북마크 보기</a>
        </span>
        <span> | </span>
        <span>
            <a href="bookmark-group.jsp">북마크 그룹 관리</a>
        </span>
    </div>
    <h2>북마크를 삭제하시겠습니까?</h2>
    <div>
        <table>
            <tr>
                <td class="title">북마크 이름</td>
                <td><%=bookmarkName%></td>
            </tr>
            <tr>
                <td class="title">와이파이명</td>
                <td><%=request.getParameter("name")%></td>
            </tr>
            <tr>
                <td class="title">등록일자</td>
                <td><%=inputDate%></td>
            </tr>
        </table>

        <a href="bookmark-list.jsp">돌아가기</a>
        <button onclick="bookmark_delete_db(<%=bookmarkNum%>)">삭제</button>
    </div>
</body>

</html>

<script>
    function bookmark_delete_db(num) {
        window.location.href = "/bookmark_delete_db.jsp?num=" + num;
    }
</script>