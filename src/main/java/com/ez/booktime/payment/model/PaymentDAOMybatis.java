package com.ez.booktime.payment.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAOMybatis implements PaymentDAO{
	private String namespace = "com.mybatis.mapper.payment.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertPayment(PaymentVO vo) {
		return sqlSession.insert(namespace+"insertPayment",	vo);
	}

	@Override
	public int insertPaymentDetail(Map<String, Object> map) {
		return sqlSession.insert(namespace+"insertPaymentDetail", map);
	}

	@Override
	public PaymentVO selectPaymentByPayNo(PaymentVO vo) {
		return sqlSession.selectOne(namespace+"selectPaymentByPayNo", vo);
	}

	@Override
	public List<PaymentDetailVO> selectPaymentDetail(String payNo) {
		return sqlSession.selectList(namespace+"selectPaymentDetail", payNo);
	}

	@Override
	public List<PaymentVO> selectPaymentList(PaymentDateVO vo) {
		return sqlSession.selectList(namespace+"selectPaymentList", vo);
	}

	@Override
	public int totalPaymentList(PaymentDateVO vo) {
		return sqlSession.selectOne(namespace+"totalPaymentList", vo);
	}

	@Override
	public int updateProgress(PaymentVO vo) {
		return sqlSession.update(namespace+"updateProgress",vo);
	}

	@Override
	public int countPaymentByIsbn(Map<String, Object> map) {
		return sqlSession.selectOne(namespace+"countPaymentByIsbn", map);
	}
	
}
