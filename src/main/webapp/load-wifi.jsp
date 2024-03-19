<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="load-wifi.css">
    <title>Document</title>
</head>

<body>
    <h1>
        <%= request.getParameter("totalDataCount")%>개의 WIFI 정보를 정상적으로 저장하였습니다.
    </h1>
    <a href="index.jsp">홈으로 가기</a>
</body>

</html>