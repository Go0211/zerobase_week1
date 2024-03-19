<%@ page import="com.example.wifi.Wifi" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="detail.css">
    <title>Document</title>
</head>

<%
    Connection conn = DBConnect.getConnection();
    Statement stmt_detail = null;
    ResultSet rs_detail = null;
    Wifi wifi = new Wifi();

    Statement stmt_book = null;
    ResultSet rs_book = null;
    ArrayList<String> bookmarkGroup = new ArrayList<>();

    try {
        String detailQuery = "SELECT * , SQRT(POWER(\" + lat + \"-x_coordinates, 2) + POWER(\" + lnt + \"-y_coordinates, 2)) AS km " +
                "FROM wifi_info " +
                "WHERE num = "+ request.getParameter("num");
        stmt_detail = conn.createStatement();
        rs_detail = stmt_detail.executeQuery(detailQuery);
        rs_detail.next();

        wifi.setNum(rs_detail.getInt("num"));
        wifi.setKm(rs_detail.getDouble("km"));
        wifi.setManagement_number(rs_detail.getString("management_number"));
        wifi.setAutonomous_region(rs_detail.getString("autonomous_region"));
        wifi.setWifi_name(rs_detail.getString("wifi_name"));
        wifi.setRoad_name_address(rs_detail.getString("road_name_address"));
        wifi.setDetail_address(rs_detail.getString("detail_address"));
        wifi.setInstall_floor(rs_detail.getString("install_floor"));
        wifi.setInstall_type(rs_detail.getString("install_type"));
        wifi.setInstall_organization(rs_detail.getString("install_organization"));
        wifi.setService_division(rs_detail.getString("service_division"));
        wifi.setNet_kind(rs_detail.getString("net_kind"));
        wifi.setInstall_date(rs_detail.getString("install_date"));
        wifi.setInput_output(rs_detail.getString("input_output"));
        wifi.setWifi_environment(rs_detail.getString("wifi_environment"));
        wifi.setX_coordinates(rs_detail.getDouble("x_coordinates"));
        wifi.setY_coordinates(rs_detail.getDouble("Y_coordinates"));
        wifi.setWork_date(LocalDateTime.now());

        String bookmarkQuery = "SELECT *"
                + "FROM bookmark_group " +
                "ORDER BY seq";
        stmt_book = conn.createStatement();
        rs_book = stmt_book.executeQuery(bookmarkQuery);

        while (rs_book.next()) {
            bookmarkGroup.add(rs_book.getString("bookmark_name"));
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    } finally {
        // 리소스 해제
        try {
            if (rs_book != null) rs_book.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt_book != null) stmt_book.close();
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


<body>
<h1>와이파이 정보 구하기</h1>
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
    <form action="bookmark-match.jsp?num=<%=wifi.getNum()%>" method="post">
        <select name="bookmark_group_name">
            <option selected disabled hidden>북마크 그룹 이름 선택</option>
            <% for (String bookmarkGroupName : bookmarkGroup) {%>
            <option value="<%=bookmarkGroupName%>"><%=bookmarkGroupName%>
            </option>
            <%}%>
        </select>
        <span>
            <button type="submit">북마크 추가하기</button>
        </span>
    </form>
</div>
<div>
    <table>
        <tr>
            <td class="title">거리(Km)</td>
            <td><%=wifi.getKm()%>
            </td>
        </tr>
        <tr>
            <td class="title">관리번호</td>
            <td><%=wifi.getManagement_number()%>
            </td>
        </tr>
        <tr>
            <td class="title">자치구</td>
            <td><%=wifi.getAutonomous_region()%>
            </td>
        </tr>
        <tr>
            <td class="title">와이파이명</td>
            <td>
                <a href="detail.jsp?num=<%=wifi.getNum()%>">
                    <%=wifi.getWifi_name()%>
                </a>
            </td>
        </tr>
        <tr>
            <td class="title">도로명주소</td>
            <td><%=wifi.getRoad_name_address()%>
            </td>
        </tr>
        <tr>
            <td class="title">상세주소</td>
            <td><%=wifi.getDetail_address()%>
            </td>
        </tr>
        <tr>
            <td class="title">설치위치(층)</td>
            <td><%=wifi.getInstall_floor()%>
            </td>
        </tr>
        <tr>
            <td class="title">설치유형</td>
            <td><%=wifi.getInstall_type()%>
            </td>
        </tr>
        <tr>
            <td class="title">설치기관</td>
            <td><%=wifi.getInstall_organization()%>
            </td>
        </tr>
        <tr>
            <td class="title">서비스구분</td>
            <td><%=wifi.getService_division()%>
            </td>
        </tr>
        <tr>
            <td class="title">망종류</td>
            <td><%=wifi.getNet_kind()%>
            </td>
        </tr>
        <tr>
            <td class="title">설치년도</td>
            <td><%=wifi.getInstall_date()%>
            </td>
        </tr>
        <tr>
            <td class="title">실내외구분</td>
            <td><%=wifi.getInput_output()%>
            </td>
        </tr>
        <tr>
            <td class="title">WIFI접속환경</td>
            <td><%=wifi.getWifi_environment()%>
            </td>
        </tr>
        <tr>
            <td class="title">X좌표</td>
            <td><%=wifi.getX_coordinates()%>
            </td>
        </tr>
        <tr>
            <td class="title">Y좌표</td>
            <td><%=wifi.getY_coordinates()%>
            </td>
        </tr>
        <tr>
            <td class="title">작업일자</td>
            <td><%=wifi.getWork_date()%>
            </td>
        </tr>
    </table>
</div>
</body>

</html>