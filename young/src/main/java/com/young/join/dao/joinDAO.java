package com.young.join.dao;

import java.util.*;
import org.springframework.stereotype.Repository;

@Repository("joinDAO")
public class joinDAO extends AbstractDAO{

	public void insertjoin(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("join.insertjoin",params);
	}

	public List<Map<String, Object>> selectJoinId(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("join.selectJoinId",params);
	}

	public void deleteJoin(Map<String, Object> params) {
		// TODO Auto-generated method stub
		delete("join.deleteJoin",params);
	}

	public Map<String, Object> selectJoinIdMap(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("join.selectJoinIdMap",params);
	}

	public List<Map<String, Object>> chooseReader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("join.chooseReader",params);
	}

	public int joincnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("join.joincnt",params);
	}

	public List<Map<String, Object>> joinMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("join.joinMember",params);
	}

	public void updateYleader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("join.updateYleader",params);
	}

	public void updateNleader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("join.updateNleader",params);
	}

	public List<Map<String, Object>> projectLeader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("join.projectLeader",params);
	}

	public Map<String, Object> joinMemberCheck(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("join.joinMemberCheck",params);
	}

	public int leaderNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("join.leaderNum",params);
	}

	public int joinNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("join.joinNum",params);
	}


}
