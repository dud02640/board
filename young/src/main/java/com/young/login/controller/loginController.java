package com.young.login.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Method;
import org.imgscalr.Scalr.Mode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.young.join.service.joinService;
import com.young.login.sevice.loginService;
import com.young.project.service.projectService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class loginController {
	
	private static final Logger logger = LoggerFactory.getLogger(loginController.class);
	
	@Resource(name="loginService")
	private loginService loginService;
	
	@Resource(name="projectService")
	private projectService projectService;
	
	@Resource(name="joinService")
	private joinService joinService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = "/login/login.do")
	public String loginview(HttpServletRequest req) {
		
		return "/login/login";
	}
	
	@RequestMapping(value = "/login/logout.do")
	public String loginout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		
		return "/login/login";
	}
	@RequestMapping(value = "/login/memberlist.do")
	public String memberlist(@RequestParam Map<String,Object> params, Model model) {	
		int currentpage=(params.get("selectPage")==null||params.get("selectPage")==""? 1:Integer.parseInt(params.get("selectPage").toString()));
		int startpage=(params.get("startpage")==null? 1:1);
		int endpageNo=(params.get("endpageNo")==null? 10:10);		//아래쪽 페이징 최대개수
		int endpage = 0;
		int currentpageDB=0;				//DB에서의 시작 컬럼 번호
		int paging=10;						//한페이지당 list 컬럼의 수

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
		
		List<Map<String,Object>> memberlist = loginService.selectMemberList(params);

		int membercnt= loginService.selectMemberCnt(params);			//member 총인원

		if(membercnt%paging!=0)							//paging으로 나누었을떄 0 이면 나뉜 페이지 보여줌
			endpage=membercnt/paging+1;					//맴버 총 수에서 10을 나누고 나머지 페이지
		else
			endpage=membercnt/paging;
		
		if(endpageNo>endpage) {
			endpageNo=endpage;
		}
		params.put("currentpage", currentpage);
		params.put("endpage",endpage);
		params.put("endpageNo",endpageNo);
		
		model.addAttribute("membercnt", membercnt);
		model.addAttribute("params",params);
		model.addAttribute("memberlist",memberlist);
		
		return "/login/memberlist";
	}
	
	
	@RequestMapping(value = "/login/member.do")
	public String insertmember(HttpServletRequest req,@RequestParam("userImage") MultipartFile file,@RequestParam Map<String,Object> params, Model model,HttpServletResponse response) throws IOException {
		String mes=URLEncoder.encode(params.get("mes").toString());
		
		String db_url="/thumnail/"+file.getOriginalFilename();
		/*	  서버에 이미지나 문서 업로드시 서버 세팅(Tomcat기준)  */
		/*	 server.xml <Context docBase> 밑에 추가 논리주소 물리주소 같게 해주기  */
		/*<Context docBase="C:\thumnail" path="/thumnail" reloadable="true" /> */

		if(file.isEmpty()) {
			db_url="/thumnail/noimg.PNG";
		}else {	
			File thum =new File("C:\\thumnail\\"+ file.getOriginalFilename());
			int w=200;
			int h=200;
			BufferedImage originalImg = ImageIO.read(file.getInputStream()); 
			BufferedImage thumbnailImg = new BufferedImage(w, h, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g = thumbnailImg.createGraphics(); 
			g.drawImage(originalImg, 0, 0, w, h, null); 
			ImageIO.write(thumbnailImg, "jpg", thum);	
		}
		try {
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		params.put("userImage",  db_url);
		loginService.insertMember(params);		
		
		model.addAttribute("member",params);
		return "redirect:/login/memberview.do?mes="+mes;
	}
	
	@RequestMapping(value = "/login/memberview.do")
	public String memberview(@RequestParam Map<String,Object> params,Model model,HttpServletResponse response) throws IOException {
		String mes=(String) params.get("mes");
		System.out.println(mes);
		if(mes==null||mes==""){
		}
		else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('" + mes + "');</script>");
			out.flush();
		}
		return "/login/member";
	}

	@RequestMapping(value = "/login/checkId.do")
	@ResponseBody
	public String checkId(HttpServletResponse res,@RequestParam Map<String,Object> params,Model model) {
		
		System.out.println(params.get("userEmail"));
		params.put("userId", params.get("userId"));

		int checkdoubleId = loginService.selectCheckId(params);

		return Integer.toString(checkdoubleId);
	}
	
	@RequestMapping(value = "/login/logincheck.do")
	public String loginCheck(HttpServletRequest req,@RequestParam Map<String,Object> params ,Model model,HttpServletResponse response) throws IOException {
		String returnUrl="";
		
		Map<String,Object> logincheck = loginService.selectCheckMember(params);
		
		if(logincheck==null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println("<script>alert('회원정보를 정확히 입력하시오');</script>");
			out.flush();
			model.addAttribute("id", params.get("userId"));
		
			returnUrl= "/login/login";
		}else {
			HttpSession session=req.getSession();
			session.setAttribute("userId",logincheck.get("userId"));
			session.setAttribute("userName",logincheck.get("userName"));
			session.setAttribute("adminYn",logincheck.get("adminYn"));

			System.out.println(session.getAttribute("uesrId"));
			returnUrl= "redirect:/project/main.do";
		}
		return returnUrl;
	}
	@RequestMapping(value = "/login/updatememberView.do")
	public String memberupdate(@RequestParam Map<String,Object> params, Model model) {
		
		Map<String,Object> memberinfo = loginService.selectMemberinfo(params);

		model.addAttribute("memberinfo",memberinfo);
		
		return "/login/updatemember";
	}
	@RequestMapping(value = "/login/updatemember.do")
	public String memberupdatedo(HttpServletRequest req,@RequestParam("userImage") MultipartFile file,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException {
		
		String db_url="/thumnail/"+file.getOriginalFilename();
		/*	  서버에 이미지나 문서 업로드시 서버 세팅(Tomcat기준)  */
		/*	 server.xml <Context docBase> 밑에 추가 논리주소 물리주소 같게 해주기  */
		/*<Context docBase="C:\thumnail" path="/thumnail" reloadable="true" /> */

		if(file.isEmpty()) {
			db_url="/thumnail/noimg.PNG";
		}else {	
			File thum =new File("C:\\thumnail\\"+ file.getOriginalFilename());
			int w=200;
			int h=200;
			BufferedImage originalImg = ImageIO.read(file.getInputStream()); 
			BufferedImage thumbnailImg = new BufferedImage(w, h, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g = thumbnailImg.createGraphics(); 
			g.drawImage(originalImg, 0, 0, w, h, null); 
			ImageIO.write(thumbnailImg, "jpg", thum);	
		}
		try {
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		params.put("userImage",  db_url);
		
		loginService.updateMemberinfo(params);
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" + mes + "');</script>");
		out.flush();
		
		return "forward:/login/memberlist.do";
	}
	@RequestMapping(value = "/login/deletemember.do")
	public String memberdeletedo(@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException {
		
		loginService.deleteMemberinfo(params);
		
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" + mes + "');</script>");
		out.flush();
		
		return "forward:/login/memberlist.do";
	}
	
	@RequestMapping(value = "/login/multidelete.do")
	public String multidelete(@RequestParam("checkbox")String[] checkbox,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException {

		for(String chk : checkbox) {
			loginService.multiDelete(chk);
		}
		
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" + mes + "');</script>");
		out.flush();
		
		return "forward:/login/memberlist.do";
	}
	
	@RequestMapping(value = "/login/indivisualView.do")
	public String indivisualView(@RequestParam Map<String,Object> params,HttpServletResponse response,Model model){
		
		int currentpage=(params.get("selectPage")==null||params.get("selectPage")==""? 1:Integer.parseInt(params.get("selectPage").toString()));
		int startpage=(params.get("startpage")==null? 1:1);
		int endpageNo=(params.get("endpageNo")==null? 10:10);		//아래쪽 페이징 최대개수
		int endpage = 0;
		int currentpageDB=0;				//DB에서의 시작 컬럼 번호
		int paging=10;						//한페이지당 list 컬럼의 수

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
		
		List<Map<String,Object>> indivisualView = loginService.indivisualView(params);

		int indivisualViewCnt= loginService.indivisualViewCnt(params);			//member 총인원

		if(indivisualViewCnt%paging!=0)							//paging으로 나누었을떄 0 이면 나뉜 페이지 보여줌
			endpage=indivisualViewCnt/paging+1;					//맴버 총 수에서 10을 나누고 나머지 페이지
		else
			endpage=indivisualViewCnt/paging;
		
		if(endpageNo>endpage) {
			endpageNo=endpage;
		}
		params.put("currentpage", currentpage);
		params.put("endpage",endpage);
		params.put("endpageNo",endpageNo);
		
		model.addAttribute("indivisualViewCnt", indivisualViewCnt);
		model.addAttribute("params",params);
		model.addAttribute("indivisualView",indivisualView);
		
		return "/login/indivisual";
	}
	@RequestMapping(value = "/login/userIndivisualView.do")
	public String userIndivisualView(HttpServletRequest req,@RequestParam Map<String,Object> params,Model model){
		System.out.println("@@@@@"+params);
		HttpSession session = req.getSession();
/*		
		session.setAttribute("getuserId", req.getParameter("gibonId"));
		session.getAttribute("getuserId")==null*/

		if(params.get("gibonId")==null) {
			return "forward:/login/indivisualView.do";
		}else {
			Map<String,Object> userInfo = loginService.userInfo(params);
			List<Map<String,Object>> userProjectInfo = projectService.userProjectInfo(params);
			
			params.put("userId",session.getAttribute("userId"));
			params.put("adminYn",session.getAttribute("adminYn"));
			
			model.addAttribute("params", params);
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("userProjectInfo", userProjectInfo);
			
			return "/login/userIndivisualView";
		}

	}
	@RequestMapping(value = "/login/indivisualWorkList.do")
	public String indivisualWorkList(HttpServletRequest req,@RequestParam Map<String,Object> params,Model model){
		HttpSession session=req.getSession();
		
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
		
		Map<String,Object> selectMemberinfo = loginService.selectMemberinfo(params);
		List<Map<String,Object>> userWorkList = projectService.userWorkList(params);
	
		int userWorkListCnt= projectService.userWorkListCnt(params);			//member 총인원
	
		if(userWorkListCnt%paging!=0)							//paging으로 나누었을떄 0 이면 나뉜 페이지 보여줌
			endpage=userWorkListCnt/paging+1;					//맴버 총 수에서 10을 나누고 나머지 페이지
		else
			endpage=userWorkListCnt/paging;
		
		if(endpageNo>endpage) {
			endpageNo=endpage;
		}
	/*			Map<String,Object> joinMemberCheck= joinService.joinMemberCheck(params);*/
		
		params.put("currentpage", currentpage);
		params.put("endpage",endpage);
		params.put("endpageNo",endpageNo);
		
	/*			model.addAttribute("joinMemberCheck", joinMemberCheck);*/
	/*			model.addAttribute("updateListModalPage", updateListModalPage);*/	
		params.put("userId",session.getAttribute("userId"));
		params.put("adminYn",session.getAttribute("adminYn"));
		
		model.addAttribute("userWorkListCnt", userWorkListCnt);
		model.addAttribute("selectMemberinfo", selectMemberinfo);
		model.addAttribute("userWorkList",userWorkList);
		model.addAttribute("params",params);
		
		return "/login/indivisualWorkList";
	}
	
	@RequestMapping(value = "/login/pwCheck.do")
	@ResponseBody
	public String pwCheck(@RequestParam Map<String,Object> params){

		int pwCheck = loginService.pwCheck(params);

		return Integer.toString(pwCheck);
	}
	
	@RequestMapping(value = "/login/deletePwCheck.do")
	@ResponseBody
	public String deletePwCheck(@RequestParam Map<String,Object> params){

		int pwCheck = loginService.pwCheck(params);
		loginService.deleteMemberinfo(params);
		
		return Integer.toString(pwCheck);
	}
	
	@RequestMapping(value = "/login/updatUserInfo.do")
	public String updatUserInfo(@RequestParam("userImage") MultipartFile file,HttpServletRequest req,@RequestParam Map<String,Object> params,HttpServletResponse response) throws IOException {

		String db_url="/thumnail/"+file.getOriginalFilename();
		/*	  서버에 이미지나 문서 업로드시 서버 세팅(Tomcat기준)  */
		/*	 server.xml <Context docBase> 밑에 추가 논리주소 물리주소 같게 해주기  */
		/*<Context docBase="C:\thumnail" path="/thumnail" reloadable="true" /> */

		if(file.isEmpty()) {
			db_url="/thumnail/noimg.PNG";
		}else {	
			File thum =new File("C:\\thumnail\\"+ file.getOriginalFilename());
			int w=200;
			int h=200;
			BufferedImage originalImg = ImageIO.read(file.getInputStream()); 
			BufferedImage thumbnailImg = new BufferedImage(w, h, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g = thumbnailImg.createGraphics(); 
			g.drawImage(originalImg, 0, 0, w, h, null); 
			ImageIO.write(thumbnailImg, "jpg", thum);	
		}
		
		try {
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		params.put("userImage", db_url);
		
		loginService.updateMemberinfo(params);
		
		String mes=(String) params.get("mes");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('" + mes + "');</script>");
		out.flush();
		
		return "forward:/login/userIndivisualView.do";
	}
	
	@RequestMapping(value = "/login/userHistory.do")
	public String userHistory(@RequestParam Map<String,Object> params,Model model) {
		
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
		
	/*			Map<String,Object> updateListModalPage= projectService.selectupdateListModalPage(params);*/
		List<Map<String,Object>> userHistory = loginService.userHistory(params);
	
		int userHistoryCnt = loginService.userHistoryCnt(params);			//member 총인원
	
		if(userHistoryCnt%paging!=0)							//paging으로 나누었을떄 0 이면 나뉜 페이지 보여줌
			endpage=userHistoryCnt/paging+1;					//맴버 총 수에서 10을 나누고 나머지 페이지
		else
			endpage=userHistoryCnt/paging;
		
		if(endpageNo>endpage) {
			endpageNo=endpage;
		}
	/*			Map<String,Object> joinMemberCheck= joinService.joinMemberCheck(params);*/
		
		params.put("currentpage", currentpage);
		params.put("endpage",endpage);
		params.put("endpageNo",endpageNo);
		
	/*			model.addAttribute("joinMemberCheck", joinMemberCheck);*/
	/*			model.addAttribute("updateListModalPage", updateListModalPage);*/	
		model.addAttribute("userHistoryCnt", userHistoryCnt);
		model.addAttribute("params",params);
		model.addAttribute("userHistory",userHistory);
		
		return "/login/userHistoryModal";
	}
	@RequestMapping(value = "/login/saveImg.do")
	public String saveImg(HttpServletRequest req,@RequestParam("userImage") MultipartFile file,@RequestParam Map<String,Object> params) throws IllegalStateException, IOException {
		
/*		BufferedImage img = ImageIO.read(f);
		BufferedImage thumbImg=Scalr.resize(img,Method.QUALITY,Mode.AUTOMATIC,50,50,Scalr.OP_ANTIALIAS);
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		ImageIO.write(thumbImg, "jpg",os);
		File f1 =new File(root_path+"data\\"+ file.getOriginalFilename());
		ImageIO.write(thumbImg, "jpg",f1);*/
		
		String db_url="/thumnail/"+file.getOriginalFilename();
		/*	  서버에 이미지나 문서 업로드시 서버 세팅(Tomcat기준)  */
		/*	 server.xml <Context docBase> 밑에 추가 논리주소 물리주소 같게 해주기  */
		/*<Context docBase="C:\thumnail" path="/thumnail" reloadable="true" /> */

		if(file.isEmpty()) {
			db_url="/thumnail/noimg.PNG";
		}else {	
			File thum =new File("C:\\thumnail\\"+ file.getOriginalFilename());
			int w=200;
			int h=200;
			BufferedImage originalImg = ImageIO.read(file.getInputStream()); 
			BufferedImage thumbnailImg = new BufferedImage(w, h, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g = thumbnailImg.createGraphics(); 
			g.drawImage(originalImg, 0, 0, w, h, null); 
			ImageIO.write(thumbnailImg, "jpg", thum);	
		}
		
		try {
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		params.put("userImage", db_url);
		loginService.insertSaveImg(params);
				
		return "forward:/login/userIndivisualView.do";
	}
	
}
