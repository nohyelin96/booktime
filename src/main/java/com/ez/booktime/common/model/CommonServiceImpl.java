package com.ez.booktime.common.model;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonServiceImpl implements CommonService{
	@Autowired
	private CommonDAO commonDao;

	@Override
	public Map<String, Object> countInfo() {
		return commonDao.countInfo();
	}
	
}
