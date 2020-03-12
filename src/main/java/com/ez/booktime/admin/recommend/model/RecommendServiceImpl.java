package com.ez.booktime.admin.recommend.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ez.booktime.admin.recommend.model.RecommendVO;

@Service
public class RecommendServiceImpl implements RecommendService{
	@Autowired
	private RecommendDAO recommendDao;


	@Override
	public int insertRecommend(RecommendVO recommendVo) {
		return recommendDao.insertRecommend(recommendVo);
	}
	
	@Override
	public List<RecommendVO> selectRecommend() {
		return recommendDao.selectRecommend();
	}

	@Override
	public int deleteRecommend(String recombookNoList) {
		String[] noList = recombookNoList.split("&");
		
		int count = 0;
		if(noList==null) {
			
			int recombookNo=Integer.parseInt(recombookNoList);
			
			
			int cnt = recommendDao.deleteRecommend(recombookNo);
			if(cnt>0) count++;
		}else {
			for(String recombookNo : noList) {
				
				int no=Integer.parseInt(recombookNo);
			
				
				System.out.println("아래:"+no);
				int cnt = recommendDao.deleteRecommend(no);
				if(cnt>0) count++;
			}
		}		
		return count;
	}
	
}
