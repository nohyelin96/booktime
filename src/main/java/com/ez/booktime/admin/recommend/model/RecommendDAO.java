package com.ez.booktime.admin.recommend.model;

import java.util.List;

public interface RecommendDAO {
	int insertRecommend(RecommendVO recommendVo);
	List<RecommendVO> selectRecommend();
	int deleteRecommend(int recombookNo);
}
