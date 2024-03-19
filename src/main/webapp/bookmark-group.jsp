<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.example.wifi.BookmarkGroup" %>
<%@ page import="com.example.wifi.BookmarkGroup" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<BookmarkGroup> bookmarkGroupList = new ArrayList<>();

    try {
        String query = "SELECT * "
                + "FROM bookmark_group "
                + "ORDER BY seq ";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            BookmarkGroup bookmarkGroup = new BookmarkGroup();
            bookmarkGroup.setNum(rs.getInt("id"));
            bookmarkGroup.setBookmark_name(rs.getString("bookmark_name"));
            bookmarkGroup.setSeq(rs.getInt("seq"));
            bookmarkGroup.setInput_date(rs.getString("input_date"));
            bookmarkGroup.setUpdate_date(rs.getString("update_date"));
            bookmarkGroupList.add(bookmarkGroup);
        }

        session.setAttribute("bookmarkList", bookmarkGroupList);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bookmark-group.css">
    <title>Document</title>
</head>

<body>
<h1>위치 히스토리 목록</h1>
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
    <button onClick="location.href='bookmark-group-add.jsp'">북마크 그룹 이름 추가</button>
</div>
<div>
    <table>
        <thead>
        <tr>
            <td>ID</td>
            <td>북마크이름</td>
            <td>순서</td>
            <td>등록일자</td>
            <td>수정일자</td>
            <td>비고</td>
        </tr>
        </thead>
        <tbody>
        <%
            if (!bookmarkGroupList.isEmpty()) {
                for (int i = 0; i < bookmarkGroupList.size(); i++) {
        %>
        <tr>
            <td><%=bookmarkGroupList.get(i).getNum()%></td>
            <td><%=bookmarkGroupList.get(i).getBookmark_name()%></td>
            <td><%=bookmarkGroupList.get(i).getSeq()%></td>
            <td><%=bookmarkGroupList.get(i).getInput_date()%></td>
            <td><%=bookmarkGroupList.get(i).getUpdate_date() == null ? "" : bookmarkGroupList.get(i).getUpdate_date()%></td>
            <td>
                <a href="bookmark-group-edit.jsp?num=<%=bookmarkGroupList.get(i).getNum()%>">수정</a>
                <a href="bookmark-group-delete.jsp?num=<%=bookmarkGroupList.get(i).getNum()%>">삭제</a>
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