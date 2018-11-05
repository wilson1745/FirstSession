<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="sun.misc.BASE64Decoder" />
<jsp:directive.page trimDirectiveWhitespaces="true" />
<%
	request.setCharacterEncoding("UTF-8");

	// 清除輸出
	out.clear();

	for (Cookie cookie : request.getCookies()) {

		if (cookie.getName().equals("file")) {

			// 從 Cookie 中取二進位資料
			byte[] binary = BASE64Decoder.class.newInstance().decodeBuffer(cookie.getValue().replace(" ", ""));

			// 設置內容類別型為 gif 圖片
			response.setHeader("Content-Type", "image/gif");
			response.setHeader("Content-Disposition", "inline;filename=cookie.gif");
			response.setHeader("Connection", "close");

			// 設置長度
			response.setContentLength(binary.length);

			// 輸出到用戶端
			response.getOutputStream().write(binary);
			response.getOutputStream().flush();
			response.getOutputStream().close();

			return;
		}
	}
%>
