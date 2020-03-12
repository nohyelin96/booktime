package com.ez.booktime.payment.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ez.booktime.favorite.model.FavoriteDAO;
import com.ez.booktime.mileage.model.MileageService;
import com.ez.booktime.mileage.model.MileageVO;
import com.ez.booktime.user.model.UserService;
import com.google.api.client.util.Data;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private PaymentDAO paymentDao;

	@Autowired
	private MileageService mileageService;
	
	@Autowired
	private UserService UserService;
	
	@Autowired
	private FavoriteDAO favoriteDao;
	
	@Override
	@Transactional
	public int insertPayment(PaymentVO vo, String reason) {
		int cnt = 0;
		
		try {
			cnt = paymentDao.insertPayment(vo);	//주문테이블
			
			if(cnt>0) {
				MileageVO mVo = new MileageVO();
				mVo.setPayNo(vo.getPayNo());
				mVo.setUsePoint(vo.getUsePoint());	//사용 포인트
				mVo.setUserid(vo.getUserid());
				mVo.setReason(reason);
				
				if(vo.getNonMember().equals("0") && vo.getUsePoint()>0) {
					cnt = mileageService.insertMileage(mVo);	//마일리지 테이블(히스토리)
				}
				if(cnt>0) {
					if(vo.getNonMember().equals("0") && vo.getUsePoint()>0) {
						cnt = UserService.updateMileage(mVo);	//유저 마일리지
					}
					
					if(cnt>0) {
						List<PaymentDetailVO> list = vo.getDetails();
						
						int count = 0;
						for(PaymentDetailVO dVo : list) {
							Map<String, Object> map = new HashMap<String, Object>();
							
							map.put("payNo", vo.getPayNo());
							map.put("isbn", dVo.getIsbn());
							map.put("bookName", dVo.getBookName());
							map.put("price", dVo.getPrice());
							map.put("qty", dVo.getQty());
							
							cnt = paymentDao.insertPaymentDetail(map);	//주문 상세정보 테이블
							if(cnt>0) {
								map.put("userid", vo.getUserid());
								cnt = favoriteDao.paymentOkDeleteCart(map);	//구입한 책은 장바구니에서 삭제
								if(cnt>0) count++;
							}
						}
						if(count==list.size()) cnt=1;
						
					}
				}
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			cnt = -1;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		
		return cnt;
	}

	@Override
	public PaymentVO selectPayment(PaymentVO vo) {
		PaymentVO pVo = paymentDao.selectPaymentByPayNo(vo);
		
		if(pVo!=null) {
			List<PaymentDetailVO> list
				= paymentDao.selectPaymentDetail(vo.getPayNo());
			
			pVo.setDetails(list);
		}
		return pVo;
	}

	@Override
	public List<PaymentVO> selectPaymentList(PaymentDateVO vo) {
		List<PaymentVO> list = paymentDao.selectPaymentList(vo);
		
		List<PaymentVO> compList = new ArrayList<PaymentVO>();
		if(list!=null && !list.isEmpty()) {
			for(PaymentVO pVo : list) {
				pVo.setDetails(paymentDao.selectPaymentDetail(pVo.getPayNo()));
				
				compList.add(pVo);
			}
		}
		
		return compList;
	}

	@Override
	public int totalPaymentList(PaymentDateVO vo) {
		return paymentDao.totalPaymentList(vo);
	}

	@Override
	@Transactional
	public int updateProgress(PaymentVO vo, MileageVO mVo) {
		int cnt = 0;
		
		try {
			cnt = paymentDao.updateProgress(vo);
			//(Payment테이블) payNo로 progress,message 업데이트
			
			if(cnt>0) {
				String progress = vo.getProgress();
				
				if(mVo!=null && mVo.getUserid()!=null && !mVo.getUserid().isEmpty()) { //로그인시
					if(progress.equals("환불 처리됨") || progress.equals("구매확정")) {
						mVo.setPayNo(vo.getPayNo());
						if(mVo.getUsePoint()>0 || mVo.getSavingPoint()>0) {
							if(progress.equals("환불 처리됨")) {
								mVo.setSavingPoint(mVo.getSavingPoint()+mVo.getUsePoint());
								mVo.setUsePoint(0);
								mVo.setReason("환불 반환");
							}else if(progress.equals("구매확정")) {
								mVo.setReason("구매확정");
							}
							
							cnt = UserService.updateMileage(mVo);
							//(User테이블)userid로 savingPoint는 증가시키고, usePoint는 감소시킴

							if(cnt>0) {
								cnt = mileageService.insertMileage(mVo);
								//(mileage테이블) savingPoint와 usePoint변동을 기록함
								// userid와 payNo를 필요로함
							}
						}
						
					}
				}
				
			}
		}catch (RuntimeException e) {
			cnt = -1;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public int countPaymentByIsbn(Map<String, Object> map) {
		return paymentDao.countPaymentByIsbn(map);
	}
	
}
