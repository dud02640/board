package com.young.interceptor;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.young.login.sevice.loginService;

public class LoginInterceptor extends HandlerInterceptorAdapter{

    public boolean preHandle(HttpServletRequest req, HttpServletResponse response,Object handler) {
    	String userId=(String) req.getSession().getAttribute("userId");
    	String userPw=(String) req.getSession().getAttribute("userPw");

    	try {
            if(userId == null){
            		response.sendRedirect("/login/login.do");	
/*                	System.out.println("@@@@@@@@@@@@@"+userId);
                	System.out.println(userPw);*/
                    return false;              
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
/*    	System.out.println("@@@@@@@@@@@@@"+userId);
    	System.out.println(userPw);*/
        return true;
    }

}
