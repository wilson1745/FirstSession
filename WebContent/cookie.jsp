<%@ page language="java" pageEncoding="UTF-8" errorPage="login.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");

	String username = "";
	int visitTimes = 0;

	// 所有的 cookie
	Cookie[] cookies = request.getCookies();

	// 遍歷所有的 Cookie 尋找 使用者帳號資訊與登錄次數資訊
	for (int i = 0; cookies != null && i < cookies.length; i++) {
		Cookie cookie = cookies[i];
		if ("username".equals(cookie.getName())) {
			username = cookie.getValue();
		} else if ("visitTimes".equals(cookie.getName())) {
			visitTimes = Integer.parseInt(cookie.getValue());
			cookie.setValue("" + ++visitTimes);
		}
	}

	// 如果沒有找到 Cookie 中保存的用戶名，則轉到登錄介面
	if (username == null || username.trim().equals("")) { throw new Exception("您還沒有登錄。請先登錄"); }

	// 修改 Cookie，更新用戶的訪問次數
	Cookie visitTimesCookie = new Cookie("visitTimes", Integer.toString(visitTimes++));
	response.addCookie(visitTimesCookie);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cookie</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div align="center" style="margin: 10px;">
		<fieldset>
			<legend>登錄信息</legend>
			<form action="login.jsp" method="post">
				<table>
					<tr>
						<td>您的帳號：</td>
						<td><%=username%></td>
					</tr>
					<tr>
						<td>登錄次數：</td>
						<td><%=visitTimes%></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="button" value=" 刷  新 "
							onclick="location='<%=request.getRequestURI()%>?ts=' + new Date().getTime(); "
							class="button"></td>
					</tr>
				</table>
			</form>
		</fieldset>
	</div>

</body>
</html>
