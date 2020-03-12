// Call the dataTables jQuery plugin
// Korean
var lang_kor = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 건)",
        "infoEmpty" : "0건",
        "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "첫 페이지",
            "last" : "마지막 페이지",
            "next" : "다음",
            "previous" : "이전"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };

var lang_kor_payMent = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 건)",
        "infoEmpty" : "0건",
        "infoFiltered" : "(전체 _MAX_ 건 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "첫 페이지",
            "last" : "마지막 페이지",
            "next" : "다음",
            "previous" : "이전"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };
	
$(document).ready(function() {
  $('#dataTable').DataTable({
	  language : lang_kor //or lang_eng
  });

  $('#dataTable3').DataTable({
	language : lang_kor, //or lang_eng

	// 기본 표시 건수를 50건으로 설정 
	displayLength: 5, 

	// 표시 건수기능 숨기기
	lengthChange: false,
	// 정렬 기능 숨기기
	ordering: false,
	
	initComplete: function () {
	    $('.dataTables_filter input[type="search"]').css({ 'width': '400px', 'display': 'block', 'float': 'right' });
	    }
  });
  
  $('#dataTable2').DataTable({
		language : lang_kor, //or lang_eng

		// 기본 표시 건수를 50건으로 설정 
		displayLength: 5, 

		// 표시 건수기능 숨기기
		lengthChange: false,
		// 정렬 기능 숨기기
		ordering: false,
		
		initComplete: function () {
		    $('.dataTables_filter input[type="search"]').css({ 'width': '400px', 'display': 'block', 'float': 'right' });
		    }
	  });
  
  $('#dataTable1').DataTable({
		language : lang_kor, //or lang_eng

		// 기본 표시 건수를 50건으로 설정 
		displayLength: 5, 

		// 표시 건수기능 숨기기
		lengthChange: false,
		// 정렬 기능 숨기기
		ordering: false,
		
		initComplete: function () {
		    $('.dataTables_filter input[type="search"]').css({ 'width': '400px', 'display': 'block', 'float': 'right' });
		    }
	  });

  $('#dataTable4').DataTable({
	  language : lang_kor_payMent
  });

});
