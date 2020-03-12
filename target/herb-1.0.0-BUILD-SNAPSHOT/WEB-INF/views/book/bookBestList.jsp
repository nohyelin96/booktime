<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
	.list-group {
	    display: -ms-flexbox;
	    display: flex;
	    -ms-flex-direction: column;
	    flex-direction: column;
	    padding-left: 0;
	    margin-bottom: 0;
	}
</style>
<div class="top_best">
	<!-- 신간베스트 for -->
	<c:forEach var="map" items="${specialList }" end="3">
		<table class="bookBestTable" width=25%>
			<tbody>
				<tr>
	    			<td style="background:url(//image.aladin.co.kr/img/browse/2010/bg_08.gif) repeat-x top;
	    						background-color:#FFFFFF; padding:19px 9px 10px 9px;">
						<table width=90% border="0" align="center" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td class="bookBestContent" width="172" valign="top" style="text-align:center;">
   										<div style="position:relative; text-align:center; font-size:1em;">
   											<a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>'>
   											<img src="${map['cover'] }"></a>
   										</div><br> 
   										<a href='<c:url value="/book/bookDetail.do?ItemId=${map['isbn13'] }"/>' 
   										class="bk66" style="color:#3399FF">${map['title'] }</a>
   										<br> <span class="author">
   										${fn:substring(map["author"], 0, fn:indexOf(map["author"], "("))} 
   										지음 | ${MAP['publisher'] }</span>
   										<br> <span class="br2010_p2" style="color:red;"  >
   										${map['priceSales'] }</span>원
   										(<span class="br2010_p2" style="color:red">10</span>% 할인)/
       										<img class="wonImage" src='<c:url value="/resources/images/m.gif"/>' 
       										align="absmiddle"> 
       										<fmt:formatNumber value="${map['priceStandard']/100*5}"/>원
			        				</td>
			        				<td width="10">&nbsp;</td>
	       						</tr>
		 					</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
    </c:forEach>
</div>