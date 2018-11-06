<%@ page language="java" pageEncoding="UTF-8" isErrorPage="false"%>
<jsp:directive.page import="java.security.MessageDigest" />
<%!// 金鑰
	//private static final String KEY = ":cookie@helloweenvsfei.com";
	private static final String KEY = ":cookie@wilson.com";

	// MD5 加密演算法
	public final static String calcMD5(String ss) {

		String s = ss == null ? "" : ss;

		char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String action = request.getParameter("action");

	if ("login".equals(action)) {

		String account = request.getParameter("account");
		String password = request.getParameter("password");
		int timeout = new Integer(request.getParameter("timeout"));

		// 把帳號連同金鑰使用MD5後加密後保存
		String ssid = calcMD5(account + KEY);

		// 把帳號保存到Cookie中 並控制有效期
		Cookie accountCookie = new Cookie("account", account);
		accountCookie.setMaxAge(timeout);

		// 把加密結果保存到Cookie中 並控制有效期
		Cookie ssidCookie = new Cookie("ssid", ssid);
		ssidCookie.setMaxAge(timeout);

		response.addCookie(accountCookie);
		response.addCookie(ssidCookie);

		// 重新請求本頁面
		response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
		return;
	} else if ("logout".equals(action)) {

		// 刪除Cookie中的帳號
		Cookie accountCookie = new Cookie("account", "");
		accountCookie.setMaxAge(0);

		// 刪除Cookie中的加密結果
		Cookie ssidCookie = new Cookie("ssid", "");
		ssidCookie.setMaxAge(0);

		response.addCookie(accountCookie);
		response.addCookie(ssidCookie);

		// 重新請求本頁面
		response.sendRedirect(request.getRequestURI() + "?" + System.currentTimeMillis());
		return;
	}

	boolean loggin = false;

	String account = null;
	String ssid = null;

	// 獲取Cookie中的account與ssid
	if (request.getCookies() != null) {
		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equals("account"))
				account = cookie.getValue();
			if (cookie.getName().equals("ssid"))
				ssid = cookie.getValue();
		}
	}

	if (account != null && ssid != null) {
		// 如果加密規則正確, 則視為已經登錄
		loggin = ssid.equals(calcMD5(account + KEY));
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=loggin ? "歡迎您回來" : "請先登錄"%></title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div align="center" style="margin: 10px;">
		<fieldset>
			<legend>當前有效的 Cookie</legend>
			<script>
				document.write(document.cookie);
			</script>
		</fieldset>
		<fieldset>
			<legend><%=loggin ? "歡迎您回來" : "請先登錄"%></legend>
			<%
				if (loggin) {
			%>
			歡迎您, ${ cookie.account.value }. &nbsp;&nbsp; <a
				href="${ pageContext.request.requestURI }?action=logout">註銷</a>
			<%
				} else {
			%>
			<form action="${ pageContext.request.requestURI }?action=login"
				method="post">
				<table>
					<tr>
						<td>帳號：</td>
						<td><input type="text" name="account" style="width: 200px;">
						</td>
					</tr>
					<tr>
						<td>密碼：</td>
						<td><input type="password" name="password"
							style="width: 200px;"></td>
					</tr>
					<tr>
						<td>有效期：</td>
						<td><input type="radio" name="timeout" value="-1" checked>
							關閉流覽器即失效 <br /> <input type="radio" name="timeout"
							value="<%=30 * 24 * 60 * 60%>"> 30天內有效 <br /> <input
							type="radio" name="timeout" value="<%=Integer.MAX_VALUE%>">
							永久有效 <br /></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value=" 登  錄 " class="button">
						</td>
					</tr>
				</table>
			</form>
			<%
				}
			%>
		</fieldset>
	</div>

</body>
</html>
