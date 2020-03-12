package com.ez.booktime.category.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookCategoryServiceImpl implements BookCategoryService{
	
	@Autowired
	private BookCategoryDAO cateDao;

	@Override
	public List<BookCategoryVO> selectAllCategory() {
		return cateDao.selectAllCategory();
	}

	@Override
	public BookCategoryVO selectCategoryInfoByName(String categoryName) {
		return cateDao.selectCategoryInfoByName(categoryName);
	}

	@Override
	public List<BookCategoryVO> selectCatgoryBar() {
		return cateDao.selectCatgoryBar();
	}
}
