package com.ez.booktime.favorite.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FavoriteServiceImpl implements FavoriteService{
	
	@Autowired
	private FavoriteDAO favoriteDao;

	@Override
	@Transactional
	public int insertFavorite(FavoriteVO vo) {
		int cnt = 0;
		try {
			int count = favoriteDao.selectFavoriteCount(vo);
			
			if(count>0) { //장바구니, 즐겨찾기 기록이 이미 있으면
				if(vo.getGroup().equals("FAVORITE")) {
					cnt = 1;
				}else {
					cnt = favoriteDao.updateCart(vo);
				}
					
			}else {
				cnt = favoriteDao.insertFavorite(vo);
			}
			
		}catch (RuntimeException e) {
			e.printStackTrace();
			cnt = -1;
		}
		
		return cnt;
	}

	@Override
	@Transactional
	public int deleteCartOverDate() {
		int cnt = 0;
		try{
			int userCartDateLimit = 30;
			int nonUserCartDateLimit = 1;
			
			cnt = favoriteDao.deleteCartOverDate(userCartDateLimit);
			cnt = favoriteDao.deleteCartOverDateByNonUser(nonUserCartDateLimit);
			
		}catch (RuntimeException e) {
			e.printStackTrace();
			cnt = -1;
		}
		return cnt;
	}

	@Override
	public List<FavoriteVO> selectFavorite(FavoriteVO vo) {
		return favoriteDao.selectFavorite(vo);
	}

	@Override
	@Transactional
	public int updateQty(FavoriteVO vo) {
		int count = 0;
		for(FavoriteVO fVo :vo.getVoList()) {
			try{
				int cnt = favoriteDao.updateQty(fVo);
				if(cnt>0) count++;
			}catch (RuntimeException e) {
				e.printStackTrace();
				count = -1;
			}
		}
		return count;
	}

	@Override
	public int deleteFavorite(String favoriteNoList, String group) {
		String[] noList = favoriteNoList.split("&");
		
		int count = 0;
		if(noList==null) {
			FavoriteVO vo = new FavoriteVO();
			vo.setGroup(group);
			vo.setFavoriteNo(Integer.parseInt(favoriteNoList));
			
			int cnt = favoriteDao.deleteFavorite(vo);
			if(cnt>0) count++;
		}else {
			for(String favoriteNo : noList) {
				FavoriteVO vo = new FavoriteVO();
				vo.setGroup(group);
				vo.setFavoriteNo(Integer.parseInt(favoriteNo));
				
				int cnt = favoriteDao.deleteFavorite(vo);
				if(cnt>0) count++;
			}
		}
		
		return count;
	}

	@Override
	public int moveFavorite(String favoriteNoList) {
		String[] noList =  favoriteNoList.split("&");
		
		int count = 0;
		
		if(noList==null) {
			FavoriteVO vo = selectOneFavorite(Integer.parseInt(favoriteNoList));
			vo.setGroup("CART");
			
			int cnt = insertFavorite(vo);
			if(cnt>0) count++;
		}else {
			for(String no : noList) {
				FavoriteVO vo = selectOneFavorite(Integer.parseInt(no));
				vo.setGroup("CART");
				
				int cnt = insertFavorite(vo);
				if(cnt>0) count++;
			}
		}
		
		return count;
	}

	@Override
	public FavoriteVO selectOneFavorite(int favoriteNo) {
		return favoriteDao.selectOneFavorite(favoriteNo);
	}
}
