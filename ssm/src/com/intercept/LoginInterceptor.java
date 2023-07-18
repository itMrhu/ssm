package com.intercept;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.model.Student;
import com.model.User;

public class LoginInterceptor implements HandlerInterceptor {
	
	
	

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {

		String url=request.getRequestURI();
		if(url.indexOf("/login")>0){
			
			return true;
		}
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		System.out.println(user);
		if(user!=null){
			
			return true;
		}
		Student stu=(Student)session.getAttribute("currentStudent");
		System.out.println(user);
		if(stu!=null){
			
			return true;
		}
		request.setAttribute("msg", "您还没有登录，请先登录！");		
		request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);		
		return false;
	}

}
