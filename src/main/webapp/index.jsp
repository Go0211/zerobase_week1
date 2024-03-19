<%@ page import="com.example.wifi.Wifi" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="index.css">
    <title>Document</title>
</head>

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
    <form action="/get_near_wifi_info.jsp" method="get">
        <span>LAT : </span>
        <input type="text" id="lat" name="lat">
        <span>, </span>
        <span>LNT : </span>
        <input type="text" id="lnt" name="lnt">
        <span>
            <button type="button" id="getMyLocation">내 위치 가져오기</button>
        </span>
        <span>
            <button type="submit" id="getNearWifiInfo">근처 WIFI 정보보기</button>
        </span>
    </form>
</div>
<div>
    <table>
        <thead>
        <tr>
            <td>거리(Km)</td>
            <td>관리번호</td>
            <td>자치구</td>
            <td>와이파이명</td>
            <td>도로명주소</td>
            <td>상세주소</td>
            <td>설치위치(층)</td>
            <td>설치유형</td>
            <td>설치기관</td>
            <td>서비스구분</td>
            <td>망종류</td>
            <td>설치년도</td>
            <td>실내외구분</td>
            <td>WIFI접속환경</td>
            <td>X좌표</td>
            <td>Y좌표</td>
            <td>작업일자</td>
        </tr>
        </thead>
        <tbody>

        <%
            ArrayList<Wifi> wifis = (ArrayList<Wifi>) session.getAttribute("wifiListInfo20");
            System.out.println(request.getAttribute("wifiListInfo20"));
            if (wifis != null) {
                for (Wifi wifi : wifis) {
        %>
        <tr>
            <td>
                <%= String.format("%.4f", wifi.getKm())%>
            </td>
            <td>
                <%= wifi.getManagement_number()%>
            </td>
            <td>
                <%= wifi.getAutonomous_region()%>
            </td>
            <td>
                <a href="detail.jsp?num=<%=wifi.getNum()%>"
                >
                    <%= wifi.getWifi_name()%>
                </a>
            </td>
            <td>
                <%= wifi.getRoad_name_address()%>
            </td>
            <td>
                <%= wifi.getDetail_address()%>
            </td>
            <td>
                <%= wifi.getInstall_floor()%>
            </td>
            <td>
                <%= wifi.getInstall_type()%>
            </td>
            <td>
                <%= wifi.getInstall_organization()%>
            </td>
            <td>
                <%= wifi.getService_division()%>
            </td>
            <td>
                <%= wifi.getNet_kind()%>
            </td>
            <td>
                <%= wifi.getInstall_date()%>
            </td>
            <td>
                <%= wifi.getInput_output()%>
            </td>
            <td>
                <%= wifi.getWifi_environment()%>
            </td>
            <td>
                <%= wifi.getX_coordinates()%>
            </td>
            <td>
                <%= wifi.getY_coordinates()%>
            </td>
            <td>
                <%= wifi.getWork_date()%>
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
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
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
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    var getMyLocation = document.getElementById("getMyLocation");
    getMyLocation.addEventListener("click", getLocation);

    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError);
        } else {
            alert("Geolocation이 브라우저에서는 지원되지 않습니다.");
        }
    }

    function showPosition(position) {
        var lat = document.getElementById("lat");
        var lnt = document.getElementById("lnt");
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;

        lat.value = latitude;
        lnt.value = longitude;

        // var postData = {
        //     x_coordinates: latitude,
        //     y_coordinates: longitude,
        // };
        //
        // $.ajax({
        //     url: "/history_insert.jsp", // 요청할 URL
        //     type: "POST", // 요청 방식
        //     data: JSON.stringify(postData), // 데이터를 JSON 문자열로 변환
        //     contentType: "application/json; charset=utf-8",
        //     dataType: "json",
        //     success: function (response) {
        //         // 성공적으로 응답을 받았을 때 수행할 작업
        //         console.log(response);
        //     },
        //     error: function (error) {
        //         // 에러 발생 시 수행할 작업
        //         console.error(error);
        //     }
        // });
    }

    function showError(error) {
        switch (error.code) {
            case error.PERMISSION_DENIED:
                alert("사용자가 Geolocation 허용요청을 거부했습니다.");
                break;
            case error.POSITION_UNAVAILABLE:
                alert("위치정보를 사용할 수 없습니다.");
                break;
            case error.TIMEOUT:
                alert("사용자 위치를 가져오라는 요청이 시간 초과되었습니다.");
                break;
            case error.UNKNOWN_ERROR:
                alert("알 수 없는 오류가 발생했습니다.");
                break;
        }
    }
</script>