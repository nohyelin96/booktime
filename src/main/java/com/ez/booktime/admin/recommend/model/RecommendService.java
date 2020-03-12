package com.ez.booktime.admin.recommend.model;

import java.util.List;

public interface RecommendService {
	int insertRecommend(RecommendVO recommendVo);
	List<RecommendVO> selectRecommend();
	int deleteRecommend(String recombookNoList);
}
