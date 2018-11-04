<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="java.net.URLEncoder" />
<jsp:directive.page import="java.net.URLDecoder" />
<%
	// 使用中文的 Cookie. name 與 value 都使用 UTF-8 編碼. 
	Cookie cookie = new Cookie(URLEncoder.encode("姓名", "UTF-8"), URLEncoder.encode("劉京華", "UTF-8"));

	// 發送到用戶端	
	response.addCookie(cookie);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cookie Encoding</title>
</head>
<body>
	<%
		if (request.getCookies() != null) {
			for (Cookie cc : request.getCookies()) {

				String cookieName = URLDecoder.decode(cc.getName(), "UTF-8");
				String cookieValue = URLDecoder.decode(cc.getValue(), "UTF-8");

				out.println(cookieName + "=");
				out.println(cookieValue + "; <br/>");
			}
		} else {
			out.println("Cookie 已經寫入用戶端. 請刷新頁面. ");
		}
	%>
</body>
</html>
