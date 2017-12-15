package com.young.project.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.young.project.dao.projectDAO;

@Service("projectService")
public class projectImpl implements projectService{

	@Resource(name="projectDAO")
	private projectDAO projectDAO;
	
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> gomap) {
		// TODO Auto-generated method stub
		return projectDAO.selectBoardList(gomap);
	}

	@Override
	public List<Map<String, Object>> selectCheckMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectCheckMember(params);
	}

	@Override
	public void insertProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.insertProject(params);
	}

	@Override
	public Map<String, Object> selectProjectDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectProjectDetail(params);
	}

	@Override
	public void updateProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.updateProject(params);
	}

	@Override
	public void deleteProject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.deleteProject(params);
	}

	@Override
	public List<Map<String, Object>> searchMember(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.searchMember(params);
	}

	@Override
	public int selectBoardListCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectBoardListCnt(params);
	}

	@Override
	public void insertCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.insertCheckList(params);
	}

	@Override
	public List<Map<String, Object>> selectWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectWorkList(params);
	}

	@Override
	public List<Map<String, Object>> selectWorkListAll(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectWorkListAll(params);
	}
	

	@Override
	public int selectWorkListAllCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectWorkListAllCnt(params);
	}

	@Override
	public void workMultiDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.workMultiDelete(params);
	}

	@Override
	public Map<String, Object> selectupdateListModalPage(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectupdateListModalPage(params);
	}

	@Override
	public void updateCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.updateCheckList(params);
	}

	@Override
	public List<Map<String, Object>> selectCheckListAll(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectCheckListAll(params);
	}

	@Override
	public int selectCheckListAllCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectCheckListAllCnt(params);
	}

	@Override
	public void medo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.medo(params);
	}

	@Override
	public void workCancel(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.workCancel(params);
	}

	@Override
	public Map<String, Object> updateWorkListModalView(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return  projectDAO.updateWorkListModalView(params);
	}

	@Override
	public void updateCompleteWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.updateCompleteWorkList(params);
	}

	@Override
	public List<Map<String, Object>> selectWorkCheckList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.selectWorkCheckList(params);
	}

	@Override
	public List<Map<String, Object>> iVproject(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.iVproject(params);
	}

	@Override
	public List<Map<String, Object>> iVwork(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.iVwork(params);
	}

	@Override
	public void insertProjectLeader(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.insertProjectLeader(params);
	}

	@Override
	public void giveWorkMulti(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.giveWorkMulti(params);
	}

	@Override
	public void deletecheckListModalId(Map<String, Object> params) {
		// TODO Auto-generated method stub
		projectDAO.deletecheckListModalId(params);
	}

	@Override
	public int workNum(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.workNum(params);
	}

	@Override
	public List<Map<String, Object>> userProjectInfo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.userProjectInfo(params);
	}

	@Override
	public List<Map<String, Object>> userWorkList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.userWorkList(params);
	}

	@Override
	public int userWorkListCnt(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return projectDAO.userWorkListCnt(params);
	}
}
