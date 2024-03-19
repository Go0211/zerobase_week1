<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.example.wifi.Bookmark" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<Bookmark> bookmarkList = new ArrayList<>();

    try {
        String query = "SELECT wifi_info.num, " +
                "bookmark.id, " +
                "bookmark.bookmark_name, " +
                "wifi_info.wifi_name, " +
                "bookmark.input_date " +
                "FROM wifi_info RIGHT JOIN bookmark" +
                " ON wifi_info.num = bookmark.wifi_num";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            Bookmark bookmark = new Bookmark();
            bookmark.setWifiInfoNum(rs.getInt("num"));
            bookmark.setBookmarkNum(rs.getInt("id"));
            bookmark.setBookmark_name(rs.getString("bookmark_name"));
            bookmark.setWifi_name(rs.getString("wifi_name"));
            bookmark.setInput_date(rs.getString("input_date"));
            bookmarkList.add(bookmark);
        }
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
    <link rel="stylesheet" href="bookmark-list.css">
    <title>Document</title>
</head>

<body>
<h1>북마크 목록</h1>
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
<div>
    <table>
        <thead>
        <tr>
            <td>ID</td>
            <td>북마크이름</td>
            <td>와이파이명</td>
            <td>등록일자</td>
            <td>비고</td>
        </tr>
        </thead>
        <tbody>
        <%
            if (!bookmarkList.isEmpty()) {
                for (int i = 0; i < bookmarkList.size(); i++) {
        %>
        <tr>
            <td><%=bookmarkList.get(i).getBookmarkNum()%></td>
            <td><%=bookmarkList.get(i).getBookmark_name()%></td>
            <td>
                <a href="detail.jsp?num=<%=bookmarkList.get(i).getWifiInfoNum()%>">
                    <%=bookmarkList.get(i).getWifi_name()%>
                </a>
            </td>
            <td><%=bookmarkList.get(i).getInput_date()%></td>
            <td>
                <a href="bookmark-delete.jsp?id=<%=bookmarkList.get(i).getBookmarkNum()%>
                &name=<%=bookmarkList.get(i).getWifi_name()%>">
                    삭제
                </a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>

</html>