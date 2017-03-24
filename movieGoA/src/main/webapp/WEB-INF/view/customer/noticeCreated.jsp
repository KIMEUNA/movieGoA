<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css" />

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
.bs-write table {
    width: 100%;
    border: 0;
    border-spacing: 0;
}
.table tbody tr td {
    border-top: none;
    font-weight: normal;
	font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
} 
.bs-write table td {
	padding: 3px 3px 3px 3px;
}

.bs-write .td1 {
    min-width: 100px;
    min-height: 30px;
    color: #666;
    vertical-align: middle;
}

.bs-write .td2 {
}

.bs-write .td3 {
}

.bs-write .td4 {
}

#categoryList{
	width:160px;
	height:190px;	
	border:0px;
	text-align:left;
	padding:5px;
	padding-top:0px;
	overflow-y:scroll;
    border:1px solid #ccc;
}
</style>

<script type="text/javascript">
  function check() {
        var f = document.noticeForm;

    	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            f.content.focus();
            return false;
        }

        var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/customer/noticeCreated";
    	else if(mode=="update")
    		f.action="<%=cp%>/customer/noticeUpdate";
        return true;
 }

  
  //동적으로 추가된 태그도 이벤트 처리 가능
  $(function(){
	$("body").on("change", "input[name=upload]", function(){
	
		if(! $(this).val()) {
			return;	
		}
		
		var b=false;
		$("input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b)
			return;

		var $tr, $td, $input;
		
	    $tr=$("<tr>");
	    $td=$("<td>", {class:"td1", html:"첨부"});
	    $tr.append($td);
	    $td=$("<td>", {class:"td3", colspan:"3"});
	    $input=$("<input>", {type:"file", name:"upload", class:"form-control input-sm", style:"height: 35px;"});
	    $td.append($input);
	    $tr.append($td);
	    
	    $("#tb").append($tr);
	});
  });
  
  <c:if test="${mode=='update'}">
  function deleteFile(fileIdx) {
		var url="<%=cp%>/customer/deleteFile";
		$.post(url, {fileIdx:fileIdx}, function(data){
			$("#f"+fileIdx).remove();
		}, "JSON");
  }
</c:if>

</script>

<div class="content-wrapper">
	<div id="contents">
	<div class="wrap-movie-chart">
    <section class="content-header">
    <div class="tit-heading-wrap">
     <h3>공지사항</h3> 
  </div>
  </section>
    <div>
        <form name="noticeCreatedForm" method="post" onsubmit="return check();" enctype="multipart/form-data">   <!-- enctype은 파일보낼때 필요한것 post형식이여야한다. -->
            <div class="bs-write">
                <table class="table">
                    <tbody id="tb"  align="center">
                        <tr>
                            <td class="td1">작성자명 :</td>
                            <td class="td2 col-md-5 col-sm-5">
                                <p class="form-control-static" align="left">${sessionScope.employee.name}</p>
                            </td>
                            <td class="td1" align="right">공지여부</td> 
                            <td class="td2 col-md-5 col-sm-5">
                               <div class="checkbox">
                                   <label>
                                        <input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" }> 공지
                                    </label>
                                </div>
                            </td>
                        </tr>
                     
                        <tr>
                            <td class="td1">구분</td>
                            <td colspan="3" class="td3">
                            	<input type="text" name="type" class="form-control input-sm" value="${dto.type}" required="required">
                            </td>
                        </tr>
                    
                        <tr>
                            <td class="td1">제목</td>
                            <td colspan="3" class="td3">
                                <input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1" colspan="4" style="padding-bottom: 0px;">내용</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="td4">
                            	<textarea name="content" class="form-control" rows="15" required="required">${dto.content}</textarea>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1">첨부</td>
                            <td colspan="3" class="td3">
                                <input type="file" name="upload" class="form-control input-sm" style="height: 35px;">
                            </td>
                        </tr>
                    </tbody>
                    
<c:if test="${mode=='update'}">
   <c:forEach var="vo" items="${listFile}">
                       <tr id="f${vo.fileIdx}"> 
                            <td class="td1">첨부파일</td>
                            <td colspan="3" class="td3"> 
                                ${vo.originalFilename}
                                | <a href="javascript:deleteFile('${vo.fileIdx}');">삭제</a>	        
                            </td>
                       </tr>
   </c:forEach>
</c:if>			           
                    <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; padding-top: 15px;">
                                  <button type="submit" class="btn btn-default btn-sm wbtn">확인</button>   
                                  <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/customer/noticeList';">취소</button>
                            
		                              <c:if test="${mode=='update'}">
		                                      <input type="hidden"  name="page" value="${page}">
		                                      <input type="hidden" name="noticeIdx" value="${dto.noticeIdx}">
		                             </c:if>
                            </td>
                        </tr>
                    </tfoot>
                    
                    
                </table>
            </div>
        </form>
    </div>
</div>
</div>
</div>
