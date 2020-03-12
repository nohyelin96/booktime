<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<c:if test="${empty sessionScope.userid }">
	<div class="card my-4" style="border-bottom: 0;">
		<div class="card-header">댓글 목록 (로그인 후 작성할 수 있습니다.)</div>
	</div>
</c:if>
<c:if test="${!empty sessionScope.userid }">    
<!-- Comments Form -->
        <div class="card my-4">
          <h5 class="card-header">댓글쓰기 : </h5>
          <div class="card-body">
            <form name="replyWrite" method="post">
              <div class="form-group">
                <textarea class="form-control" rows="3" id="replyContent" name="replyContent"></textarea>
              <input type="hidden" id="boardNo" name="boardNo" value="${param.boardNo }" />
              </div>
              <button type="button" class="btn btn-primary" id="bt_reply">작성완료</button>
            </form>
          </div>
        </div>
</c:if>
<!-- Single Comment -->
<div id="result">

</div>
<script src="<c:url value='/resources/js/date.format.js' /> "></script>
<script type="text/javascript">
/*
 * 댓글 등록하기 (Ajax)
 */
	 $(document).ready(function() {	
		 /*
		  *초기 페이지 로딩시 댓글 불러오기
		  */
		 getCommentList(); 
		 
		 $("#bt_reply").click(function(){
			if(!$("#replyContent").val()){
				alert("댓글을 입력해주세요!");
				$("#replyContent").focus();
				return;
			}
			 
			$.ajax({
			url : "<c:url value='/freeBoard/reply/replyWrite.do'/> ",
			type : "post",
			data : {
				"boardNo": $("#boardNo").val(),
				"replyContent": $("#replyContent").val()
			},
			success : function(result){
				alert("댓글 등록 완료");
				getCommentList();
				$("#replyContent").val("");
			},
			error:function(xhr, status, error){
				alert("Error:"+ status+"=>"+ error);
			}
		});			
			event.preventDefault();			
	 });
 
 /*
 *댓글 불러오기 (Ajax)
 */
 function getCommentList(){
		 
		 $.ajax({
			url : "<c:url value='/freeBoard/reply/replyList.do'/>", 
			type : "get",
			datatype:"json",
			data:{
				"boardNo": $("#boardNo").val()
			},
			success: function(result){
				var str="";
				$.each(result, function(idx, item){
					//날짜 형식 변환
					var d = new Date(item.replyRegdate);
					var date=d.format("yyyy-mm-dd HH:MM:ss");
					
					//대댓글 레이아웃 처리
					if(item.step=='2'){
						str+='<div class="media mb-4">';
						str+='<div class="media-body">';
						str+='<div class=row>';
						str+='<div class="ml-5 col text-left">';
						str+='└ Re : ';
						str+='<input type="hidden" name="replyNo" class="replyNo" value='+item.replyNo +' />';
						str+='<input type="hidden" name="groupNo" class="groupNo" value='+item.groupNo +' />'
						str+='<input type="hidden" name="step" value='+item.step +' />';
						str+='<h5 class="mt-0">'+item.userid +'</h5>';
						str+='<p>'+item.replyContent +'</p>';
						str+='<p style="color:gray">작성일 : '+date +'</p>';
						str+='</div>';
					}else{

					str+='<div class="media mb-4 pl-2">';					
					str+='<div class="media-body">';
					str+='<div class=row>';
					str+='<div class="col text-left">';
					str+='<input type="hidden" name="replyNo" class="replyNo" value='+item.replyNo +' />';

					str+='<input type="hidden" name="groupNo" class="groupNo" value='+item.groupNo +' />'

					str+='<input type="hidden" name="step" value='+item.step +' />';
					str+='<h5 class="mt-0">'+item.userid +'</h5>';
					str+='<p>'+item.replyContent +'</p>';
					str+='<p style="color:gray">작성일 : '+date +'</p>';
					str+='</div>';

					}
					str+='<div class="col text-right">';
					
					//세션 아이디 받아오기
					var sId='<%=session.getAttribute("userid") %>';
					
					if(sId!='null' && parseInt(item.step)<2){
						str+='<button class="border-0 btn-transition btn btn-outline-success selectGroup">';
						str+='<i class="fas fa-pencil-alt"></i></button>';
					}
						//세션 아이디 확인하여 본인만 삭제 기능 보이도록 함
						if(item.userid==sId){
							str+='<button class="border-0 btn-transition btn btn-outline-danger selectNo">';
							str+='<i class="fas fa-times"></i></button>';
						}

					str+='</div></div>';
					
					str+='<div id="rewrite" class="rewrite"></div>';
				
					str+='<hr></div></div>';
		
			});
				
				$("#result").html(str+"<br>");
				
				$(".selectGroup").click(function(){
					var p=$(this).parents(".row").next(".rewrite");				
					
					var no=$(this).parent().prev().find(".groupNo").val();
					
					openComment(no, p);
				});
								
				$(".selectNo").click(function(){
					var p2=$(this).parent().parent().parent();	
					
					var no2=p2.find(".replyNo").val();
					
					deleteComment(no2);
				});
				
			},
			error:function(xhr, status, error){
				alert("Error:"+ status+", "+ error);
			}
		 });
	}
//대댓글 창 열기
 function openComment(no, p){
 	var res="";
 	
 	res+='<div class="card-body">'
           +' <form name="replyWrite2" method="post">'
           +    '<div class="form-group">'
           +'<input type="hidden" name="groupNo" value="'
           +no
           +'"/>'
           +    '<textarea class="form-control" rows="3" id="replyContent2" name="replyContent2"></textarea>'
           +    '<input type="hidden" id="boardNo2" name="boardNo2" value="${param.boardNo }" />'
           +    '</div>'
           +    '<button type="button" class="btn btn-primary bt_reply2" id="bt_reply2">작성완료</button>'
           +  '</form>'
         +'</div>';
 	p.html(res+"<br>");
	$(".rewrite").not(p).html("");
	
	$(".bt_reply2").click(function(){
		var cmt = $(this).prev("div").find("textarea[name=replyContent2]");
		if(cmt.val().length<1){
			alert("내용을 입력해주세요");
			cmt.focus();
			return;
		}
		
		var no = $(this).prev().find("input[name=groupNo]").val();
		writeReComment(no);
	});
 }
	//대댓글 입력
	 function writeReComment(no){
		$.ajax({
			url : "<c:url value='/freeBoard/reply/replyWrite2.do'/> ",
			type : "post",
			data : {
				"boardNo": $("#boardNo2").val(),
				"groupNo": no,
				"replyContent": $("#replyContent2").val()
			},
			success : function(result){
				alert("댓글 등록 완료");
				getCommentList();
				$("#rewrite").empty();
			},
			error:function(xhr, status, error){
				alert("Error:"+ status+"=>"+ error);
			}
		});
	}
 //댓글 삭제
 function deleteComment(no2){
	 var replyNo=no2;

		$.ajax({
			url : "<c:url value='/freeBoard/reply/replyDelete.do'/> ",
			type : "post",
			data : {"replyNo":replyNo},
			success : function(result){
				alert("댓글 삭제 완료");
				getCommentList();
			},
			error:function(xhr, status, error){
				alert("Error:"+ status+"=>"+ error);
			}
		});
	}
});
</script>     