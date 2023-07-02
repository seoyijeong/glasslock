<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="../inc/header.jsp" %>
<div class="container mt-5 d-flex">
    <aside>
        <h4>프로필</h4>
        <ul>
            <li><a href="">비밀번호 변경</a></li>
            <li><a href="">기타메뉴</a></li>
        </ul>
    </aside>
    <div class="container">
        <h3>비밀번호 변경</h3>
        <%--로그인한 상태이기 때문에 세션에서 불러옴--%>
        <input type="text" id="memberId" value="${sessionScope.loginDTO.id}">
        <input type="text" id="memberPw" value="${sessionScope.loginDTO.pw}">
        <p id="pwChkMsg"></p>
        <input type="text" class="form-control mb-2" id="pw" name="pw" placeholder="현재비밀번호"/>
        <input type="text" class="form-control mb-2" id="newPw" name="newPw" placeholder="새 비밀번호"/>
        <input type="text" class="form-control mb-2" id="newPwConfirm" name="newPwConfirm" placeholder="새 비밀번호 확인"/>
        <div class="text-center">
            <button id="pwChangeBtn" class="btn btn-sm btn-success">비밀번호 변경</button>
        </div>
    </div>
</div>


<script>
    let pw = "";
    let currentPwChk = "";

    //현재 비밀번호 체크
    function pwCheck() {
        pw = $("#pw").val();  //(사용자)입력된 현재 비밀번호

        $.ajax({
            //요청
            url: "<c:url value="pwCheck.do"/>",
            type: "post",
            //서버에 전송될 데이터
            data: {"pw": pw},

            /*            AJAX는 비동기 자바스크립트 와 XMLHttpRequest를 사용하여 웹페이지의 콘텐츠를 동적으로 갱신하는 기술입니다.
                        AJAX 요청은 기본적으로 비동기로 실행되며, 즉 요청이 완료되기 전에 웹페이지의 나머지 부분은 계속해서 렌더링됩니다.
                        그러나 async 속성을 false로 설정하면 AJAX 요청이 동기식으로 실행됩니다.
                        즉, 요청이 완료될 때까지 웹페이지의 나머지 부분은 렌더링되지 않습니다.*/
            async:false, //동기화처리
            success: function (result) {
                if (result == "ok") { //입력된 비밀번호과 현재 비밀번호가 일치
                    alert("현재 비밀번호 확인 완료")
                    currentPwChk = true;
                } else { //입력된 비밀번호과 현재 비밀번호가 불일치
                    alert("현재 비밀번호 다시확인")
                    currentPwChk = false;
                }
            },
            error: function () {
                alert("현재 비밀번호 체크 요청실패")
            }
        });  //ajax
    }  //pwCheck

    let newPwChk = "";
    //새 비밀번호 유효성 체크
    $("#newPw").on("keyup", function () {
        let npValue = $("#newPw").val();
        if(npValue == "") {
            $("#pwChkMsg").text("새 비밀번호를 입력하세요")
            newPwChk = false;
        }else if(npValue.length < 4) {
            $("#pwChkMsg").text("4자리 이상 입력하세요")
            newPwChk = false;
        }else {
            $("#pwChkMsg").text("사용가능한 비밀번호 입니다");
            newPwChk = true;
        }
    });

    let newPwConfirmChk ="";
    //새 비밀번호 확인 체크
    $("#newPwConfirm").on("keyup", function (){
        let npcValue =$("#newPwConfirm").val();

        if(npcValue ==""){
            $("#pwChkMsg").text("확인. 비밀번호를 입력하세요")
            newPwConfirmChk = false;
        }else if($("#newPw").val() != npcValue){
            $("#pwChkMsg").text("새 비밀번호가 일치하지 않습니다")
            newPwConfirmChk = false;
        }else {
            $("#pwChkMsg").text("체크");
            newPwConfirmChk = true;
        }
    });

    //비밀번호 변경 요청(변경 버튼을 눌렀을때)
    $("#pwChangeBtn").on("click", function () {
        pwCheck();

        console.log("currentPwChk:" + currentPwChk);
        if(currentPwChk == false){
            alert("현재 비밀번호를 다시 확인하세요")
        }else if(newPwChk == false) {
            alert("새 비밀번호를 다시 확인하세요")
        }else if(newPwConfirmChk ==false){
            alert("새 비밀번호가 일치하지 않습니다. 다시확인하세요")
        }else if(currentPwChk && newPwChk && newPwConfirmChk) {
            let id = $("#memberId").val();
            //새로 입력한 비번
            let pw = $("#newPw").val();
            /*json타입 자바스크립트 객체(객체를 전송할수는 없음) 문자열로 변환하여 보냄*/
            let member = {"id": id, "pw": pw};

            $.ajax({
                url:"<c:url value="pwChange.do"/>",
                type: "post",
                data:JSON.stringify(member), //json문자열로 변환
                contentType:"application/json; charset=utf-8",
                success:function(result){
                    if(result >0) {   //수정이 되면 0 보다 큰값을 가짐
                        alert("비밀번호 변경 완료 ! 새로운 비밀번호로 로그인하세요");
                        location.href="<c:url value="/member/logout.do"/>"
                    }
                }, //success
                error:function(){
                    alert("비밀번호 변경 실패")
                }
            });
        }
    });


</script>
<jsp:include page="../inc/footer.jsp"/>