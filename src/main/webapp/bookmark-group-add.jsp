<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bookmark-add-edit.css">
    <title>Document</title>
</head>

<body>
<h1>북마크 그룹 추가</h1>
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
    <form action="bookmark_group_add_db.jsp" method="post" accept-charset="UTF-8">
        <table>
            <tr>
                <td class="title">북마크 이름</td>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <td class="title">순서</td>
                <td><input type="text" name="seq"></td>
            </tr>
        </table>
        <button type="submit">추가</button>
    </form>
</div>
</body>

</html>