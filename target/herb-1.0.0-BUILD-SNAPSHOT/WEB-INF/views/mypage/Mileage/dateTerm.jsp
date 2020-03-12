<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<link rel="stylesheet" type="text/css" 
	href="<c:url value='/resources/css/jquery-ui.min.css'/>"/>

<script type="text/javascript" 
	src="<c:url value='/resources/js/jquery-ui.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		$("#startDay").datepicker({
			dateFormat:'yy-mm-dd',
		   	changeYear:true,
		   	dayNamesMin:['일','월','화','수','목','금','토'],
		   	monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		$("#endDay").datepicker({
			dateFormat:'yy-mm-dd',
		   	changeYear:true,
		   	dayNamesMin:['일','월','화','수','목','금','토'],
		   	monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		$("#btMonth1").click(function(){
			$.setDate('m', 1);
		});
		
		$("#btMonth3").click(function(){
			$.setDate('m', 3);
		});
				
		$("#btMonth6").click(function(){
			$.setDate('m', 6);
		});
	});
	
	$.setDate=function(type, term){

		var arr=$("#endDay").val().split('-');
		var d = new Date(arr[0], arr[1]-1 , arr[2]);
		
		if(type=='d'){
			d.setDate(d.getDate()-term);
		}else if(type=='m'){
			d.setMonth(d.getMonth()-term);
		}
		
		//startDay에 년-월-일 형식으로 변환한 후 셋팅
		$("#startDay").val($.findDate(d));
		
	}
	
	$.findDate=function(date){
		//Date형식을 년-월-일 형식으로 변환
		//getFullYear()
		return date.getFullYear()+"-"+$.formatDate(date.getMonth()+1) 
			+ "-" + $.formatDate(date.getDate());		
	}
	
	$.formatDate=function(d){
		//월이나 일이 1자리인 경우 0을 붙여서 리턴
		if(d<10){
			return "0"+d;
		}else{
			return d;
		}
	}
</script>
	
	
	사용 가능 기간으로 검색
	<input type="button" id="btMonth1" value="1개월" >
	<input type="button" id="btMonth3" value="3개월" >
	<input type="button" id="btMonth6" value="6개월" >
	
	<input type="text" name="startDay" id="startDay" value="${dateSearchVO.startDay }"> 
	~
	<input type="text" name="endDay" id="endDay" value="${dateSearchVO.endDay }">
	
	
	