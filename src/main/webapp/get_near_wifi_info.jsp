<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.wifi.Wifi" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    double lat = Double.parseDouble(request.getParameter("lat"));
    double lnt = Double.parseDouble(request.getParameter("lnt"));

    Connection conn = DBConnect.getConnection();
    Statement stmt = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;

    try {
        String insertQuery = "INSERT INTO location_history ("
                + "x_coordinates,"
                + "y_coordinates,"
                + "view_date)"
                + "VALUES(?, ?, ?)";

        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setDouble(1, lat);
        pstmt.setDouble(2, lnt);
        pstmt.setString(3, String.valueOf(LocalDateTime.now()));
        pstmt.executeUpdate();
        pstmt.close();

        String selectQuery = "SELECT *, SQRT(POWER(" + lat + "-x_coordinates, 2) + POWER(" + lnt + "-y_coordinates, 2)) AS km "
                + "FROM wifi_info "
                + "ORDER BY km "
                + "LIMIT 20";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(selectQuery);

        ArrayList<Wifi> wifiList = new ArrayList<>();

        while (rs.next()) {
            Wifi wifi = new Wifi();
            wifi.setNum(rs.getInt("num"));
            wifi.setKm(rs.getDouble("km"));
            wifi.setManagement_number(rs.getString("management_number"));
            wifi.setAutonomous_region(rs.getString("autonomous_region"));
            wifi.setWifi_name(rs.getString("wifi_name"));
            wifi.setRoad_name_address(rs.getString("road_name_address"));
            wifi.setDetail_address(rs.getString("detail_address"));
            wifi.setInstall_floor(rs.getString("install_floor"));
            wifi.setInstall_type(rs.getString("install_type"));
            wifi.setInstall_organization(rs.getString("install_organization"));
            wifi.setService_division(rs.getString("service_division"));
            wifi.setNet_kind(rs.getString("net_kind"));
            wifi.setInstall_date(rs.getString("install_date"));
            wifi.setInput_output(rs.getString("input_output"));
            wifi.setWifi_environment(rs.getString("wifi_environment"));
            wifi.setX_coordinates(rs.getDouble("x_coordinates"));
            wifi.setY_coordinates(rs.getDouble("Y_coordinates"));
            wifi.setWork_date(LocalDateTime.now());
            wifiList.add(wifi);
        }

        session.setAttribute("wifiListInfo20", wifiList);
        response.sendRedirect("/?lat=" + lat + "&lnt=" + lnt);
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
