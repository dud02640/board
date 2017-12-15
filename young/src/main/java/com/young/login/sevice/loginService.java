package com.young.login.sevice;

import java.util.*;

public interface loginService {



	void insertMember(Map<String, Object> gomap);

	int selectCheckId(Map<String, Object> params);

	Map<String, Object> selectCheckMember(Map<String, Object> params);

	List<Map<String, Object>> selectMemberList(Map<String, Object> params);

	int selectMemberCnt(Map<String, Object> params);

	List<Map<String, Object>> selectMember(Map<String, Object> params);

	Map<String, Object> selectMemberinfo(Map<String, Object> params);

	void updateMemberinfo(Map<String, Object> params);

	void deleteMemberinfo(Map<String, Object> params);

	void multiDelete(String chk);

	List<Map<String, Object>> selectJoinList(Map<String, Object> params);

	int selectJoinCnt(Map<String, Object> params);

	List<Map<String, Object>> indivisualView(Map<String, Object> params);

	int indivisualViewCnt(Map<String, Object> params);

	List<Map<String, Object>> memberListView(Map<String, Object> params);

	Map<String, Object> userInfo(Map<String, Object> params);

	int pwCheck(Map<String, Object> params);

	List<Map<String, Object>> userHistory(Map<String, Object> params);

	int userHistoryCnt(Map<String, Object> params);

	List<Map<String, Object>> selectWorkJoinList(Map<String, Object> params);

	int selectWorkJoinListCnt(Map<String, Object> params);

	void insertSaveImg(Map<String, Object> params);

}
