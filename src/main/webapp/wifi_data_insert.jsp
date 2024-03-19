<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="jdk.nashorn.internal.parser.JSONParser" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="com.example.wifi.DBConnect" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;
    String insertQuery = "INSERT INTO wifi_info (" +
            "management_number," +
            "autonomous_region," +
            "wifi_name," +
            "road_name_address," +
            "detail_address," +
            "install_floor," +
            "install_type," +
            "install_organization," +
            "service_division," +
            "net_kind," +
            "install_date," +
            "input_output," +
            "wifi_environment," +
            "x_coordinates," +
            "y_coordinates," +
            "work_date)" +
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    int count = 0;


    String key = null;
    String result = "";

    if (conn != null) {
        try {
            int start = 1;
            int end = 1000;
            int totalDataCount = 0;

            PreparedStatement initialize = conn.prepareStatement("DELETE from wifi_info where num > 0");
            initialize.executeUpdate();
            initialize.close();

            String selectQuery = "SELECT keydata "
                    + "FROM keytable";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(selectQuery);
            rs.next();

            key = rs.getString("keydata");

            while (true) {
                System.out.println(count++);
                URL url = new URL("http://openapi.seoul.go.kr:8088/"
                        + key + "/json/TbPublicWifiInfo/" + start + "/" + end + "/");
                BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
                result = bf.readLine();

                // JSON 문자열을 JSONObject로 파싱
                JSONObject jsonObject = new JSONObject(result);
                JSONObject tbPublicWifiInfo = jsonObject.getJSONObject("TbPublicWifiInfo");
                JSONArray wifiInfoArray = tbPublicWifiInfo.getJSONArray("row");

                // 배열 안의 각 JSON 객체에 접근
                for (int i = 0; i < wifiInfoArray.length(); i++) {
                    JSONObject wifiInfo = wifiInfoArray.getJSONObject(i);
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, String.valueOf(wifiInfo.get("X_SWIFI_MGR_NO")));
                    pstmt.setString(2, String.valueOf(wifiInfo.get("X_SWIFI_WRDOFC")));
                    pstmt.setString(3, String.valueOf(wifiInfo.get("X_SWIFI_MAIN_NM")));
                    pstmt.setString(4, String.valueOf(wifiInfo.get("X_SWIFI_ADRES1")));
                    pstmt.setString(5, String.valueOf(wifiInfo.get("X_SWIFI_ADRES2")));
                    pstmt.setString(6, String.valueOf(wifiInfo.get("X_SWIFI_INSTL_FLOOR")));
                    pstmt.setString(7, String.valueOf(wifiInfo.get("X_SWIFI_INSTL_TY")));
                    pstmt.setString(8, String.valueOf(wifiInfo.get("X_SWIFI_INSTL_MBY")));
                    pstmt.setString(9, String.valueOf(wifiInfo.get("X_SWIFI_SVC_SE")));
                    pstmt.setString(10, String.valueOf(wifiInfo.get("X_SWIFI_CMCWR")));
                    pstmt.setString(11, String.valueOf(wifiInfo.get("X_SWIFI_CNSTC_YEAR")));
//                    pstmt.setInt(11, Integer.parseInt("1"));
                    pstmt.setString(12, String.valueOf(wifiInfo.get("X_SWIFI_INOUT_DOOR")));
                    pstmt.setString(13, String.valueOf(wifiInfo.get("X_SWIFI_REMARS3")));
                    pstmt.setFloat(14, Float.parseFloat(String.valueOf(wifiInfo.get("LAT"))));
                    pstmt.setFloat(15, Float.parseFloat(String.valueOf(wifiInfo.get("LNT"))));
//                    pstmt.setFloat(14, Float.parseFloat("0.1"));
//                    pstmt.setFloat(15, Float.parseFloat("0.1"));
                    pstmt.setString(16, String.valueOf(wifiInfo.get("WORK_DTTM")));
                    pstmt.executeUpdate();
                    pstmt.close();
                }

                totalDataCount = tbPublicWifiInfo.getInt("list_total_count");
                if (totalDataCount < end) {
                    break;
                }

                start += 1000;
                end += 1000;
            }

            conn.close();

            response.sendRedirect("load-wifi.jsp?totalDataCount=" + totalDataCount);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
