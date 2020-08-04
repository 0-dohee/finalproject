package com.example.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if(request.getSession().getAttribute("id")==null) {
			String path=request.getServletPath(); //���� �������ߴ� url�ּ�
			String query=request.getQueryString();//?�ڷ� ������ ���� ����
			if(query!=null) {
				query="?"+query;
			}else {
				query="";
			}
			
			//System.out.println(path+query);
			request.getSession().setAttribute("dest", path+query); //���������� �ߴ� url�� ���ǿ� ����
			response.sendRedirect("/user/login");
		}
		return super.preHandle(request, response, handler);
	}
	
	
}