package com.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class PwResetModeInterceptor implements HandlerInterceptor{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("PwResetMode 인터셉터");
		
	    // 메일 링크를 타고 처음 들어오는 순간(파라미터에 token이 있을 때)은 검사 패스 -> get일때
	    if (request.getParameter("token") != null) {
	        return true;
	    }
	    // Post일때
		Boolean isResetMode = (Boolean)request.getSession().getAttribute("PASSWORD_RESET_MODE");
		if(isResetMode == null || !isResetMode) {
    		response.sendRedirect("/board/main");
			return false;
		}
		
		return true;
	}
}
