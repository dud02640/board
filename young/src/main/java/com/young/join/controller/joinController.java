package com.young.join.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.young.login.controller.loginController;
import com.young.project.service.projectService;
import com.young.join.service.joinService;
import com.young.project.service.projectService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class joinController {
	
	private static final Logger logger = LoggerFactory.getLogger(loginController.class);
	
	@Resource(name="joinService")
	private joinService joinService;
	
	@Resource(name="projectService")
	private projectService projectService;
	
	@RequestMapping(value = "/join/insertJoin.do")
	public String insertmember(HttpServletRequest req,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException {
/*		String projectNo=URLEncoder.encode(params.get("projectNo").toString());*/

		joinService.insertjoin(params);	
		
		String userName=(String) params.get("userName");
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" +userName+"님"+ mes + "');</script>");
		out.flush();
		
		return "forward:/project/projectJoinList.do";
	}
	
	@RequestMapping(value = "/join/deleteJoin.do")
	public String deletemember(HttpServletRequest req,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException{
/*		String projectNo=URLEncoder.encode(params.get("projectNo").toString());*/
		System.out.println("@@@@@@@"+params);
		joinService.deleteJoin(params);	
		
		String userName=(String) params.get("userName");
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" +userName+"님"+ mes + "');</script>");
		out.flush();
		
		return"forward:/project/projectJoinList.do";
	}
	
	@RequestMapping(value = "/join/chooseReader.do")
	public ModelAndView chooseReader(HttpServletRequest req,@RequestParam Map<String,Object> params){

		ModelAndView mav= new ModelAndView();
		
		int currentpage=(params.get("selectPage")==null||params.get("selectPage")==""? 1:Integer.parseInt(params.get("selectPage").toString()));
		int startpage=(params.get("startpage")==null? 1:1);
		int endpageNo=(params.get("endpageNo")==null? 10:10);		//아래쪽 페이징 최대개수
		int endpage = 0;
		int currentpageDB=0;				//DB에서의 시작 컬럼 번호
		int paging=5;						//한페이지당 list 컬럼의 수

		/* 다음버튼 클릭시 첫페이지랑 마지막 페이지를 +10 */
		if(endpageNo<currentpage) {
			startpage=endpageNo+1;
			endpageNo+=10;	
		}
		/* 이전버튼 클릭시 첫페이지를 -10 마지막 페이지는 startpage에서 +10 (endpageNo가 유동적으로 바뀌므로 startpage를 기준잡음)  */
		else if(currentpage<startpage) {	
			startpage-=10;
			endpageNo=startpage+9;
		}				

		if(params.get("selectPage")==null||params.get("selectPage")=="") {
			currentpageDB=0;
			params.put("selectPage",startpage);
		}else 
			currentpageDB=Integer.parseInt(params.get("selectPage").toString())-1;
		
		params.put("paging",paging);
		params.put("currentpageDB",currentpageDB*paging);				//0~9,10~19 10개씩 보여준다
		params.put("startpage",startpage);
		
		List<Map<String,Object>> chooseReader = joinService.chooseReader(params);

		int joincnt= joinService.joincnt(params);			//member 총인원

		if(joincnt%paging!=0)							//paging으로 나누었을떄 0 이면 나뉜 페이지 보여줌
			endpage=joincnt/paging+1;					//맴버 총 수에서 10을 나누고 나머지 페이지
		else
			endpage=joincnt/paging;
		
		if(endpageNo>endpage) {
			endpageNo=endpage;
		}
		params.put("currentpage", currentpage);
		params.put("endpage",endpage);
		params.put("endpageNo",endpageNo);
		
		mav.addObject("params",params);
		mav.addObject("chooseReader",chooseReader);
		mav.setViewName("/project/readerchoose");	
		return mav;
	}
	
	@RequestMapping(value="/join/updateYleader.do")
	public String updateYleader(HttpServletRequest req,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException
	{
		joinService.updateYleader(params);
		
		String userName=(String) params.get("userName");
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" +userName+"님"+ mes + "');</script>");
		out.flush();
		
		return "forward:/project/projectJoinList.do";
	}
	@RequestMapping(value="/join/updateNleader.do")
	public String updateNleader(HttpServletRequest req,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException
	{
		joinService.updateNleader(params);
		
		String userName=(String) params.get("userName");
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" +userName+"님"+ mes + "');</script>");
		out.flush();
		
		return "forward:/project/projectJoinList.do";
	}
}