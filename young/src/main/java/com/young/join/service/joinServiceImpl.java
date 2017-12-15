package com.young.join.service;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.young.join.dao.joinDAO;

@Service("joinService")
public class joinServiceImpl implements joinService{

	@Resource(name="joinDAO")
	private joinDAO joinDAO;

	@Override
	public void insertjoin(Map<String, Object> params) {
		// TODO Auto-generated method stub
		joinDAO.insertjoin(params);
	}

	@Override
	public List<Map<String, Object>> selectJoinId(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.selectJoinId(params);
	}

	@Override
	public void deleteJoin(Map<String, Object> params) {
		// TODO Auto-generated method stub
		joinDAO.deleteJoin(params);
	}

	@Override
	public Map<String, Object> selectJoinIdMap(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.selectJoinIdMap(params);
	}

	@Override
	public List<Map<String, Object>> chooseReader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.chooseReader(params);
	}

	@Override
	public int joincnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) joinDAO.joincnt(params);
	}

	@Override
	public List<Map<String, Object>> joinMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return  joinDAO.joinMember(params);
	}

	@Override
	public void updateYleader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		joinDAO.updateYleader(params);
	}

	@Override
	public void updateNleader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		joinDAO.updateNleader(params);
	}

	@Override
	public List<Map<String, Object>> projectLeader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.projectLeader(params);
	}
	
	public Map<String, Object> joinMemberCheck(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.joinMemberCheck(params);
	}

	@Override
	public int leaderNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.leaderNum(params);
	}

	@Override
	public int joinNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return joinDAO.joinNum(params);
	}

}
