package com.ez.booktime.mileage.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ez.booktime.common.DateSearchVO;
import com.ez.booktime.common.SearchVO;

@Service
public class MileageServiceImpl implements MileageService{
	@Autowired
	private MileageDAO mileageDao;

	@Override
	public int insertMileage(MileageVO vo) {
		return mileageDao.insertMileage(vo);
	}

	@Override
	public List<MileageVO> selectMileageList(DateSearchVO dateSearchVo) {
		return mileageDao.selectMileageList(dateSearchVo);
	}

	@Override
	public int selectTotalRecord(DateSearchVO dateSearchVo) {
		return mileageDao.selectTotalRecord(dateSearchVo);
	}

	@Override
	public int chkMileageLimit() {
		return mileageDao.chkMileageLimit();
	}
		
}
