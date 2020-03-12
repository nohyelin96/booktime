package com.ez.booktime.category.model;

import java.util.List;

public interface BookCategoryDAO {
	List<BookCategoryVO> selectAllCategory();
	BookCategoryVO selectCategoryInfoByName(String categoryName);
	List<BookCategoryVO> selectCatgoryBar();
}
