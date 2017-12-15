package com.young.project.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("projectDAO")
public class projectDAO extends AbstractDAO{

	public List<Map<String, Object>> selectBoardList(Map<String, Object> gomap) {
		// TODO Auto-generated method stub
		return selectList("project.selectBoardList",gomap);
	}

	public List<Map<String, Object>> selectCheckMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.selectCheckMember",params);
	}

	public void insertProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("project.insertProject",params);
	}

	public Map<String, Object> selectProjectDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("project.selectProjectDetail",params);
	}

	public void updateProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.updateProject",params);
	}

	public void deleteProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.deleteProject",params);
	}

	public List<Map<String, Object>> searchMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.searchMember",params);
	}

	public int selectBoardListCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("project.selectBoardListCnt",params);
	}

	public void insertCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("project.insertCheckList",params);
	}

	public List<Map<String, Object>> selectWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.selectWorkList",params);
	}

	public List<Map<String, Object>> selectWorkListAll(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.selectWorkListAll",params);
	}

	public int selectWorkListAllCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("project.selectWorkListAllCnt",params);
	}

	public void workMultiDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		delete("project.workMutliDelete",params);
	}

	public Map<String, Object> selectupdateListModalPage(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("project.updateListModalPage",params);
	}

	public void updateCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.updateCheckList",params);
	}

	public List<Map<String, Object>> selectCheckListAll(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.selectCheckListAll",params);
	}

	public int selectCheckListAllCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("project.selectCheckListAllCnt",params);
	}

	public void medo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.medo",params);
	}

	public void workCancel(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.workCancel",params);
	}

	public Map<String, Object> updateWorkListModalView(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("project.updateWorkListModalView",params);
	}

	public void updateCompleteWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.updateCompleteWorkList",params);
	}

	public List<Map<String, Object>> selectWorkCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.selectWorkCheckList",params);
	}

	public List<Map<String, Object>> iVproject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.iVproject",params);
	}

	public List<Map<String, Object>> iVwork(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.iVwork",params);
	}

	public void insertProjectLeader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		insert("project.insertProjectLeader",params);
	}

	public void giveWorkMulti(Map<String, Object> params) {
		// TODO Auto-generated method stub
		update("project.giveWorkMulti",params);
	}

	public void deletecheckListModalId(Map<String, Object> params) {
		// TODO Auto-generated method stub
		delete("project.deletecheckListModalId",params);
	}

	public int workNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("project.workNum",params);
	}

	public List<Map<String, Object>> userProjectInfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.userProjectInfo",params);
	}

	public List<Map<String, Object>> userWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return selectList("project.userWorkList",params);
	}

	public int userWorkListCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return (int) selectOne("project.userWorkListCnt",params);
	}
}
