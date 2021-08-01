package com.mybook.interceptor;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mybook.service.MypageService;
import com.mybook.vo.BellVO;
import com.mybook.vo.NoticeVO;
import com.mybook.vo.SessionVO;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	/**
	 * ��Ʈ�ѷ� ���� �� ȣ��Ǵ� �޼ҵ�
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
								throws Exception {
		
		//���� ���� ��������
		HttpSession session = request.getSession();
		SessionVO svo = new SessionVO();
		svo.setId((String)session.getAttribute("session_id"));
		
		//���� üũ �� --> �α��� ȭ�� �̵�
		if ( svo.getId() == null ) {
			response.sendRedirect("http://localhost:9000/mybook/login.do");
			return false;
		}
		
		return true;
	}	
	
}
