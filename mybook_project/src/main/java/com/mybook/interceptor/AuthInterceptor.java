package com.mybook.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mybook.vo.SessionVO;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	/**
	 * 컨트롤러 실행 전 호출되는 메소드
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
								throws Exception {
		
		//세션 정보 가져오기
		HttpSession session = request.getSession();
		SessionVO svo = new SessionVO();
		svo.setId((String)session.getAttribute("session_id"));
		
		//세션 체크 후 --> 로그인 화면 이동
		if ( svo.getId() == null ) {
			response.sendRedirect("http://localhost:9000/mybook/login.do");
			return false;
		}
		
		return true;
	}
}
