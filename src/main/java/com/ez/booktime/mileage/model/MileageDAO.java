package com.ez.booktime.mileage.model;

import java.util.List;

import com.ez.booktime.common.DateSearchVO;

public interface MileageDAO {
	List<MileageVO> selectMileageList(DateSearchVO dateSearchVo);
	public int selectTotalRecord(DateSearchVO dateSearchVo);
	int insertMileage(MileageVO vo);
	int chkMileageLimit();
}
