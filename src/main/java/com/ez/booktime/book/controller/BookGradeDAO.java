package com.ez.booktime.book.controller;

public interface BookGradeDAO {
	int insertBookGrade(BookGradeVO vo);
	float gradeByIsbn(BookGradeVO vo);
}
