<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>

<%--head.jsp--%>
<%@ include file="../include/head.jsp" %>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="../include/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="../include/left_column.jsp" %>

    <%-- Content Wrapper. Contains page content --%>
    <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        <section class="content-header">
            <h1>
                게시글 조회
                <small>스프링연습예제</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> board</a></li>
                <li class="active">read</li>
            </ol>
        </section>

        <%-- Main content --%>
        <section class="content container-fluid">

            <div class="col-lg-12">

                <%--게시글 내용 영역--%>
                <div class="box box-primary">

                    <%--게시글 제목 영역--%>
                    <div class="box-header with-border">
                        <h3 class="box-title">글제목 : ${boardVO.title}</h3>
                        <ul class="list-inline pull-right">
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-share margin-r-5"></i>공유</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-bookmark-o margin-r-5"></i>북마크</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-thumbs-o-up margin-r-5"></i>추천 (0)</a></li>
                            <li><a href="#" class="link-black text-lg"><i class="fa fa-eye margin-r-5"></i>조회수 (${boardVO.viewcnt})</a></li>
                        </ul>
                    </div>

                    <%--게시글 내용 영역--%>
                    <div class="box-body" style="height: 700px">
                        ${fn:replace(fn:replace(fn:escapeXml(boardVO.content), newLine, "<br/>") , " ", "&nbsp;")}
                    </div>

                    <%--업로드 파일 정보 영역--%>
                    <div class="box-footer">
                        <p>파일첨부 목록영역</p>
                    </div>

                    <%--작성자 정보 영역--%>
                    <div class="box-footer">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="/dist/img/default-user-image.jpg" alt="user image">
                            <span class="username">
                                <a href="#">${boardVO.writer}</a>
                            </span>
                            <span class="description"><fmt:formatDate pattern="yyyy-MM-dd a HH:mm" value="${boardVO.regdate}"/></span>
                        </div>
                    </div>

                    <%--페이지 이동 버튼 영역--%>
                    <div class="box-footer">
                        <form role="form" method="post">
                            <input type="hidden" name="bno" value="${boardVO.bno}">
                            <input type="hidden" name="page" value="${criteria.page}">
                            <input type="hidden" name="perPageNum" value="${criteria.perPageNum}">
                            <input type="hidden" name="searchType" value="${criteria.searchType}">
                            <input type="hidden" name="keyword" value="${criteria.keyword}">
                        </form>
                        <button type="submit" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                        <div class="pull-right">
                            <button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i> 수정</button>
                            <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                        </div>
                    </div>

                </div>

                <%--댓글 입력 영역--%>
                <div class="box box-warning">
                    <div class="box-header with-border">
                        <a class="link-black text-lg"><i class="fa fa-pencil"></i> 댓글작성</a>
                    </div>
                    <div class="box-body">
                        <form class="form-horizontal">
                            <div class="form-group margin-bottom-none">
                                <div class="col-sm-10">
                                    <textarea class="form-control" id="newReplyText" rows="3" placeholder="댓글을 입력해주세요..." style="resize: none"></textarea>
                                </div>
                                <div class="col-sm-2">
                                    <input class="form-control" id="newReplyWriter" type="text" placeholder="작성자">
                                </div>
                                <hr/>
                                <div class="col-sm-2">
                                    <button type="button" class="btn btn-primary btn-block replyAddBtn"><i class="fa fa-save"></i> 저장</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="box-footer">

                    </div>
                </div>

                <%--댓글 목록 영역--%>
                <div class="box box-success collapsed-box">
                    <%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%>
                    <div class="box-header with-border">
                        <a href="" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i> </a>
                        <div class="box-tools">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                    </div>
                    <%--댓글 목록--%>
                    <div class="box-body repliesDiv">

                    </div>
                    <%--댓글 페이징--%>
                    <div class="box-footer">
                        <div class="text-center">
                            <ul class="pagination pagination-sm no-margin">

                            </ul>
                        </div>
                    </div>
                </div>

                <%--댓글 수정 modal 영역--%>
                <div class="modal fade" id="modModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">댓글수정</h4>
                            </div>
                            <div class="modal-body" data-rno>
                                <input type="hidden" class="rno"/>
                                <%--<input type="text" id="replytext" class="form-control"/>--%>
                                <textarea class="form-control" id="replytext" rows="3" style="resize: none"></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary modalModBtn">수정</button>
                            </div>
                        </div>
                    </div>
                </div>

                <%--댓글 삭제 modal 영역--%>
                <div class="modal fade" id="delModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">댓글 삭제</h4>
                                <input type="hidden" class="rno"/>
                            </div>
                            <div class="modal-body" data-rno>
                                <p>댓글을 삭제하시겠습니까?</p>
                                <input type="hidden" class="rno"/>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">아니요.</button>
                                <button type="button" class="btn btn-primary modalDelBtn">네. 삭제합니다.</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <%-- /.content --%>
    </div>
    <%-- /.content-wrapper --%>

    <%--main_footer.jsp--%>
    <%-- Main Footer --%>
    <%@ include file="../include/main_footer.jsp" %>

</div>
<%-- ./wrapper --%>

<%--plugin_js.jsp--%>
<%@ include file="../include/plugin_js.jsp" %>
<%--Handlebars JS--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>

<%--Handlebars Template : 댓글 하나의 영역--%>
<script id="replyTemplate" type="text/x-handlebars-template">
    {{#each.}}
    <div class="post replyDiv" data-rno={{rno}}>
        <div class="user-block">
            <%--댓글 작성자 프로필사진 : 추후 이미지 업로드기능 구현 예정--%>
            <img class="img-circle img-bordered-sm" src="/dist/img/default-user-image.jpg" alt="user image">
            <%--댓글 작성자--%>
            <span class="username">
                <%--작성자 이름--%>
                <a href="#">{{replyer}}</a>
                <%--댓글 삭제 버튼--%>
                <a href="#" class="pull-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal">
                    <i class="fa fa-times"> 삭제</i>
                </a>
                <%--댓글 수정 버튼--%>
                <a href="#" class="pull-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modModal">
                    <i class="fa fa-edit"> 수정</i>
                </a>
            </span>
            <%--댓글 작성일자--%>
            <span class="description">{{prettifyDate regdate}}</span>
        </div>
        <%--댓글 내용--%>
        <div class="oldReplytext">{{{escape replytext}}}</div>
        <br/>
        <%--댓글 추천 버튼--%>
        <ul class="list-inline">
            <li>
                <a href="#" class="link-black text-sm">
                    <i class="fa fa-thumbs-o-up margin-r-5"></i> 댓글 추천(0)
                </a>
            </li>
        </ul>
    </div>
    {{/each}}
</script>

<script>
    
    $(document).ready(function () {

        // 전역변수
        var bno = ${boardVO.bno}; // 현재 게시글 번호

        /*================================================게시판 첨부파일 업로드 목록 관련==================================*/


        /*================================================댓글 관련======================================================*/

        /*------------------------------------------------1. 댓글 목록------------------------------------------------*/
        // 전역변수
        var replyPage = 1; // 댓글 페이지 번호 초기화

        // 댓글 내용 : 줄바꿈/공백처리
        Handlebars.registerHelper("escape", function (text) {
           text = Handlebars.Utils.escapeExpression(text);
           text = text.replace(/(\r\n|\n|\r)/gm, "<br/>");
           text = text.replace(/( )/gm, "&nbsp;");
           return new Handlebars.SafeString(text);
        });

        // 댓글 등록일자 : 날짜/시간 2자리로 맞추기
        Handlebars.registerHelper("prettifyDate", function (timeValue) {
            var dateObj = new Date(timeValue);
            var year = dateObj.getFullYear();
            var month = dateObj.getMonth() + 1;
            var date = dateObj.getDate();
            var hours = dateObj.getHours();
            var minutes = dateObj.getMinutes();
            // 2자리 숫자로 변환
            month < 10 ? month = '0' + month : month;
            date < 10 ? date = '0' + date : date;
            hours < 10 ? hours = '0' + hours : hours;
            minutes < 10 ? minutes = '0' + minutes : minutes;
            return year + "-" + month + "-" + date + " " + hours + ":" + minutes;
        });

        // 댓글 갯수, 목록, 페이징 출력
        var getPage = function (pageInfo) {
            $.getJSON(pageInfo, function (data) {
                // 1. 댓글 갯수
                printReplyCount(data.pageMaker.totalCount);
                // 2. 댓글 목록
                printReplyList(data.list, $(".repliesDiv"), $("#replyTemplate"));
                // 3. 댓글 페이징
                printPaging(data.pageMaker, $(".pagination"))
            });
        };
        // 1. 댓글 갯수 : 댓글 유무에 따라 댓글 보기버튼 활성/비활성
        var printReplyCount = function (totalCount) {
            var replyCount = $(".replyCount");
            var collapsedBox = $(".collapsed-box");

            if (totalCount <= 0) {
                replyCount.html(" 댓글이 없습니다. 의견을 남겨주세요");
                collapsedBox.find(".btn-box-tool").remove();
                return;
            }
            replyCount.html(" 댓글목록 (" + totalCount + ")");
            collapsedBox.find(".box-tools").html(
                "<button type='button' class='btn btn-box-tool' data-widget='collapse'>"
                + "<i class='fa fa-plus'></i>"
                + "</button>"
            );
        };
        
        // 2. 댓글 목록
        var printReplyList = function (replyArr, target, templateObject) {
            var replyTemplate = Handlebars.compile(templateObject.html());
            var html = replyTemplate(replyArr);
            $(".replyDiv").remove();
            target.html(html);
        };
        
        // 3. 댓글 페이징
        var printPaging = function (pageMaker, target) {
            var str = "";
            if (pageMaker.prev) {
                str += "<li><a href='" + (pageMaker.startPage - 1) + "'>이전</a></li>";
            }
            for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
                var strClass = pageMaker.criteria.page == i ? "class=active" : "";
                str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
            }
            if (pageMaker.next) {
                str += "<li><a href='" + (pageMaker.endPage + 1) + "'>다음</a></li>"
            }
            target.html(str);
        };
        
        // 댓글 목록 출력
        getPage("/replies/" + bno + "/" + replyPage);

        // 댓글 페이지 번호 클릭 이벤트
        $(".pagination").on("click", "li a", function (event) {
            event.preventDefault();
            replyPage = $(this).attr("href");
            getPage("/replies/" + bno + "/" + replyPage);
        });
        
        /*------------------------------------------------2. 댓글 입력------------------------------------------------*/

        $(".replyAddBtn").on("click", function () {
            // 입력 form 선택자
            var replyerObj = $("#newReplyWriter");
            var replytextObj = $("#newReplyText");
            var replyer = replyerObj.val();
            var replytext = replytextObj.val();
            // 댓글 입력처리 수행
            $.ajax({
                type: "post",
                url: "/replies/",
                headers: {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override" : "POST"
                },
                dataType: "text",
                data: JSON.stringify({
                    bno:bno,
                    replyer:replyer,
                    replytext:replytext
                }),
                success: function (result) {
                    console.log("result : " + result);
                    if (result == "INSERTED") {
                        alert("댓글이 등록되었습니다.");
                        replyPage = 1;  // 페이지 1로 초기화
                        getPage("/replies/" + bno + "/" + replyPage); // 댓글 목록 호출
                        replyerObj.val("");     // 작성자 입력창 공백처리
                        replytextObj.val("");   // 댓글 입력창 공백처리
                    }
                }
            });
        });

        /*------------------------------------------------3. 댓글 수정------------------------------------------------*/

        // 댓글 수정을 위해 modal창에 선택한 댓글의 값들을 세팅
        $(".repliesDiv").on("click", ".replyDiv", function (event) {
            var reply = $(this);
            console.log(reply);
            $(".rno").val(reply.attr("data-rno"));
            $("#replytext").val(reply.find(".oldReplytext").text());
        });

        // modal 창의 댓글 수정버튼 클릭 이벤트
        $(".modalModBtn").on("click", function () {
            var rno = $(".rno").val();
            var replytext = $("#replytext").val();
            $.ajax({
                type: "put",
                url: "/replies/" + rno,
                headers: {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override" : "PUT"
                },
                dataType: "text",
                data: JSON.stringify({
                    replytext:replytext
                }),
                success: function (result) {
                    console.log("result : " + result);
                    if (result == "UPDATED") {
                        alert("댓글이 수정되었습니다.");
                        getPage("/replies/" + bno + "/" + replyPage); // 댓글 목록 호출
                        $("#modModal").modal("hide"); // modal 창 닫기
                    }
                }
            })
        });

        /*------------------------------------------------4. 댓글 삭제------------------------------------------------*/

        $(".modalDelBtn").on("click", function () {
            var rno = $(".rno").val();
            $.ajax({
                type: "delete",
                url: "/replies/" + rno,
                headers: {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override" : "DELETE"
                },
                dataType: "text",
                success: function (result) {
                    console.log("result : " + result);
                    if (result == "DELETED") {
                        alert("댓글이 삭제되었습니다.");
                        getPage("/replies/" + bno + "/" + replyPage); // 댓글 목록 호출
                        $("#delModal").modal("hide"); // modal 창 닫기
                    }
                }
            });
        });

        /*================================================게시판 페이지 이동관련===========================================*/

        // 페이지 이동 form 선택자
        var formObj = $("form[role='form']");
        console.log(formObj);

        // 수정버튼 클릭 이벤트
        $(".modBtn").on("click", function () {
            formObj.attr("action", "/board/modify");
            formObj.attr("method", "get");
            formObj.submit();
        });

        // 삭제 버튼 클릭 이벤트
        $(".delBtn").on("click", function () {
            formObj.attr("action", "/board/remove");
            formObj.submit();
        });

        // 목록 버튼 클릭 이벤트
        $(".listBtn").on("click", function () {
            $("input[name=bno]").remove();
            formObj.attr("action", "/board/list");
            formObj.attr("method", "get");
            formObj.submit();
        });

        // 수정 완료시 알림
        var result = "${msg}";
        if (result == "UPDATED") {
            alert("게시글이 수정되었습니다.");
        }

    });
    
</script>
</body>
</html>