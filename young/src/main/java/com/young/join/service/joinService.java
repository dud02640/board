package com.young.join.service;

import java.util.*;

public interface joinService {

	void insertjoin(Map<String, Object> params);

	List<Map<String, Object>> selectJoinId(Map<String, Object> params);

	void deleteJoin(Map<String, Object> params);

	Map<String, Object> selectJoinIdMap(Map<String, Object> params);

	List<Map<String, Object>> chooseReader(Map<String, Object> params);

	int joincnt(Map<String, Object> params);

	List<Map<String, Object>> joinMember(Map<String, Object> params);

	void updateYleader(Map<String, Object> params);

	void updateNleader(Map<String, Object> params);

	List<Map<String, Object>> projectLeader(Map<String, Object> params);

	Map<String, Object> joinMemberCheck(Map<String, Object> params);

	int leaderNum(Map<String, Object> params);

	int joinNum(Map<String, Object> params);


}
