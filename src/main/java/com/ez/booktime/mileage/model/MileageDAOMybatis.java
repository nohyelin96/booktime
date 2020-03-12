package com.ez.booktime.mileage.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ez.booktime.common.DateSearchVO;
import com.ez.booktime.common.SearchVO;

@Repository
public class MileageDAOMybatis implements MileageDAO{
	private String namespace = "com.mybatis.mapper.mileage.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMileage(MileageVO vo) {
		return sqlSession.insert(namespace+"insertMileage", vo);
	}

	@Override
	public List<MileageVO> selectMileageList(DateSearchVO dateSearchVo) {
		return sqlSession.selectList(namespace+"selectMileageList", dateSearchVo);
	}

	@Override
	public int selectTotalRecord(DateSearchVO dateSearchVo) {
		return sqlSession.selectOne(namespace+"selectTotalRecord",dateSearchVo);
	}

	@Override
	public int chkMileageLimit() {
		return sqlSession.update(namespace+"chkMileageLimit");
	}
	

}
