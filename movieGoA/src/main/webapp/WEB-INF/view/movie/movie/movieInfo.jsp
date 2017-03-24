<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css" />

<div class="content-wrapper">
		<div id="contents" class="">
            
            <!-- Contents Start -->
			

<!-- 실컨텐츠 시작 -->
<div class="wrap-movie-detail" id="select_main">
<section class="content-header">    
<div class="tit-heading-wrap">
    <h3>영화상세</h3>
</div>
</section>
<div class="sect-base-movie">
    <h3><strong>${dto.movieName}</strong>기본정보</h3>
    <div class="box-image">
            <span class="thumb-image"> 
                <img src="<%=cp%>/res/poster/${dto.poster}.jpg" alt="${dto.movieName} 포스터"/>
                <span class="ico-grade grade-15">${gradeName}</span>
            </span>
    </div>
    <div class="box-contents">
        <div class="title"> 
            <strong>${dto.movieName}</strong>
                  
            
            <p>${dto.movieName}, ${dto.regdate}</p>
        </div>

        <div class="spec">
            <dl>
                <dt>감독 :&nbsp;</dt>
                <dd>
                    <span>${dto.director}</span>                  
                        
                </dd>
                <dt>&nbsp;/ 배우 :&nbsp;</dt>
                <dd class="on">
                    
                        <span>${dto.actor}</span>                
                        
                </dd>
                <dt>장르 :&nbsp;${dto.genreName}</dt> 
                <dd></dd>
                <dt>&nbsp;/ 기본 :&nbsp;</dt>
                <dd class="on">${dto.gradeName},&nbsp;${dto.runTime}분,&nbsp;${dto.nation}</dd>
                <dt>개봉 :&nbsp;</dt>
                <dd class="on">${dto.regdate}</dd>


            

            </dl>
        </div>
        <span class="screentype">
        
        </span>
    </div>
</div><!-- .sect-base -->

    <div class="cols-content" id="menu">
        <div class="col-detail">
           
            <div class="sect-story-movie">
                <p style="font-size: 20px;">${dto.story}</p>
                
            </div>
           
        </div>
       

</div>

    </div>
    <span style="display:none" class="modifyCommentDummy"></span>
</div>
		</div>
</div>