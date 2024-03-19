<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.wifi.LocationHistory" %>
<%
    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<LocationHistory> myLocationList = new ArrayList<>();

    if (conn != null) {
        try {
            String query = "SELECT *"
                    + "FROM location_history "
                    + "ORDER BY num ";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                LocationHistory locationHistory = new LocationHistory();
                locationHistory.setNum(rs.getInt("num"));
                locationHistory.setLat(rs.getDouble("x_coordinates"));
                locationHistory.setLnt(rs.getDouble("y_coordinates"));
                locationHistory.setWorkDate(rs.getString("view_date"));
                myLocationList.add(locationHistory);
            }
            request.setAttribute("myLocationList", myLocationList);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="history.css">
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
    <table>
        <thead>
        <tr>
            <td>ID</td>
            <td>X좌표</td>
            <td>Y좌표</td>
            <td>조회일자</td>
            <td>비고</td>
        </tr>
        </thead>
        <tbody>
        <%
            if (!myLocationList.isEmpty()) {
                for (LocationHistory lh : myLocationList) {
        %>
        <tr>
            <td><%= lh.getNum()%></td>
            <td><%= lh.getLat()%></td>
            <td><%= lh.getLnt()%></td>
            <td><%= lh.getWorkDate()%></td>
            <td>
                <button onclick="deleteLocationHistory(<%= lh.getNum()%>)">삭제</button>
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

<script>
    function deleteLocationHistory(num) {
        window.location.href = "/history_delete.jsp?num=" + num;
    }
</script>