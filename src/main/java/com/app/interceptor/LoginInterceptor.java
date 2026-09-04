package com.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("로그인 인터셉터");
		if(request.getSession().getAttribute("LOGIN_USER") == null) {
    		response.sendRedirect("/board/main");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
