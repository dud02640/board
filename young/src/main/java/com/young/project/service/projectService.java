package com.young.project.service;

import java.util.List;
import java.util.Map;

public interface projectService {

	List<Map<String, Object>> selectBoardList(Map<String, Object> gomap);

	List<Map<String, Object>> selectCheckMember(Map<String, Object> params);

	void insertProject(Map<String, Object> params);

	Map<String, Object> selectProjectDetail(Map<String, Object> params);

	void updateProject(Map<String, Object> params);

	void deleteProject(Map<String, Object> params);

	List<Map<String, Object>> searchMember(Map<String, Object> params);

	int selectBoardListCnt(Map<String, Object> params);

	void insertCheckList(Map<String, Object> params);

	List<Map<String, Object>> selectWorkList(Map<String, Object> params);

	List<Map<String, Object>> selectWorkListAll(Map<String, Object> params);
	
	List<Map<String, Object>> selectCheckListAll(Map<String, Object> params);
	
	int selectWorkListAllCnt(Map<String, Object> params);

	void workMultiDelete(Map<String, Object> params);

	Map<String, Object> selectupdateListModalPage(Map<String, Object> params);

	void updateCheckList(Map<String, Object> params);

	int selectCheckListAllCnt(Map<String, Object> params);

	void medo(Map<String, Object> params);

	void workCancel(Map<String, Object> params);

	Map<String, Object> updateWorkListModalView(Map<String, Object> params);

	void updateCompleteWorkList(Map<String, Object> params);

	List<Map<String, Object>> selectWorkCheckList(Map<String, Object> params);

	List<Map<String, Object>> iVproject(Map<String, Object> params);

	List<Map<String, Object>> iVwork(Map<String, Object> params);

	void insertProjectLeader(Map<String, Object> params);

	void giveWorkMulti(Map<String, Object> params);

	void deletecheckListModalId(Map<String, Object> params);

	int workNum(Map<String, Object> params);

	List<Map<String, Object>> userProjectInfo(Map<String, Object> params);

	List<Map<String, Object>> userWorkList(Map<String, Object> params);

	int userWorkListCnt(Map<String, Object> params);


}
