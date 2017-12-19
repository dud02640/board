package com.young.login.dao;

import java.util.*;


import org.springframework.stereotype.Repository;

@Repository("loginDAO")
public class loginDAO extends AbstractDAO{

	public void insertMember(Map<String, Object> gomap) {
		// TODO Auto-generated method stub
		 insert("login.insertMember",gomap);
	}

	public int selectCheckId(Map<String, Object> gomap) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.checkId",gomap);
	}
	
	public Map<String, Object> selectCheckMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("login.selectCheckMember",params);
	}

	public List<Map<String, Object>> selectMemberList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.selectMemberList",params);
	}

	public int selectMemberCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.selectMemberCnt",params);
	}

	public List<Map<String, Object>> selectMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.selectMember",params);
	}

	public Object selectMemberinfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return  selectOne("login.selectMemberinfo",params);
	}

	public void updateMemberinfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("login.updateMemberinfo",params);
	}

	public void deleteMemberinfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		delete("login.deleteMemberinfo",params);
	}

	public void multiDelete(String chk) {
		// TODO Auto-generated method stub
		delete("login.multiDelete",chk);
	}

	public List<Map<String, Object>> selectJoinList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.selectJoinList",params);
	}

	public int selectJoinCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.selectJoinCnt",params);
	}

	public List<Map<String, Object>> indivisualView(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.indivisualView",params);
	}

	public int indivisualViewCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.indivisualViewCnt",params);
	}

	public List<Map<String, Object>> memberListView(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.memberListView",params);
	}

	public Map<String, Object> userInfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("login.userInfo",params);
	}

	public int pwCheck(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.pwCheck",params);
	}

	public List<Map<String, Object>> userHistory(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.userHistory",params);
	}

	public int userHistoryCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.userHistoryCnt",params);
	}

	public List<Map<String, Object>> selectWorkJoinList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.selectWorkJoinList",params);
	}

	public int selectWorkJoinListCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.selectWorkJoinListCnt",params);
	}

	public void insertSaveImg(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("login.insertSaveImg",params);
	}

	public List<Map<String, Object>> indivisualcreateView(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("login.indivisualcreateView",params);
	}

	public int indivisualcreateViewCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("login.indivisualcreateViewCnt",params);
	}

}
