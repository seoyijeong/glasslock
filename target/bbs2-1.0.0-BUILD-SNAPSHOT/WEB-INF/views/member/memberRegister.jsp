<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../inc/header.jsp"/>
<body>
<div class="container w-50 mt-5 p-5 shadow">
    <form action="memberInsert.do" method="post" onsubmit="return submitChk()">
        <h4>회원가입</h4>
        <div class="row">
            <%--<div class="col-md-8"> //버튼으로 중복체크
                <input class="form-control mb-2" type="text" name="id" id="id" placeholder="아이디">
            </div>
            <div class="col-md-4">
                <a class="btn btn-outline-info w-100" onclick="idCheck()">중복 체크</a>
            </div>--%>

            <%--체크하지 않아도 중복체크가 바로됨--%>
            <input class="form-control mb-2" onkeyup="idCheck()" type="text" name="id" id="id" placeholder="아이디"/>
            <p id="chkMsg" class="mb-2"></p>
                <%--아이디를 체크 햇는지 확인--%>
            <input type="hidden" id="isIdChk" value="no"/>
        </div>
        <input class="form-control mb-2" type="text" name="pw" placeholder="비밀번호">
        <input class="form-control mb-2" type="text" name="name" placeholder="이름">
        <input class="form-control mb-2" type="text" name="age" placeholder="나이">

        <input class="form-control mb-2" type="text" name="tel" placeholder="전화번호">

        <%--이메일 확인--%>
        <%--이메일 설정시 다운 소스
        1.https://mvnrepository.com/artifact/javax.mail
         2.spring-context-support --%>


        <div class="row">
            <div class="col-md-8">
                <input class="form-control mb-2" type="text" id="email" name="email" placeholder="이메일"/>
            </div>
            <div class="col-md-4">
                <span class="btn btn-outline-secondary" onclick="emailCheck()">인증번호받기</span>
            </div>
        </div>
        <%-- 이메일 인증코드 확인하기 --%>
        <%--이메일로 전송된 코드가 맞는지--%>
        <div class="row" id="confirmEmail">

        </div>


        <!-- 주소 -->
        <div class="row mb-2">
            <div class="col-md-6">
                <input class="form-control mb-2" type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호"
                       readonly>
            </div>
            <div class="col-md-6 p-0 ps-2">
                <a class="btn btn-sm btn-outline-secondary p-2" onclick="sample4_execDaumPostcode()">우편번호 찾기</a><br>
            </div>
        </div>

        <input class="form-control mb-2" type="text" name="roadAddr" id="sample4_roadAddress" placeholder="도로명주소"
               readonly>
        <input class="form-control mb-2" type="text" name="jibunAddr" id="sample4_jibunAddress" placeholder="지번주소"
               readonly>
        <!-- <span id="guide" style="color:#999;display:none"></span> -->
        <input class="form-control mb-2" type="text" id="sample4_detailAddress" name="detailAddr" placeholder="상세주소">
        <div class="text-center mt-3">
            <input type="submit" class="btn btn-primary" value="가입">
            <input type="reset" class="btn btn-info" value="취소">
        </div>
    </form>
</div>

<!-- The Modal -->
<div class="modal fade" id="chkModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">중복 체크 확인</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body text-center" id="chkMsg">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>

    let isEmailChk = false;  //이메일 인증을 햇는지 안했는지 기본값 false
    let severUUID = "";  //전역 변수 설정

    /*이메일 인증을 햇는지 안했는지*/
    function submitChk(){

        let isIdChk = $("#isIdChk").val();


        if(isIdChk=="no"){
            alert("아이디 중복확인을 해주세요")
            return false;
        }
        if(!isEmailChk){    //참이면 체크 안됨
            alert("이메일 인증확인을 해주세요");
            $("#email").select();
            return false;   //false면 submit이 수행이 안됨
        }



    }//submitChk


    function idCheck() {

        var uid = $('#id').val();

        if(uid.length<4){
            $('#chkMsg').html("아이디 길이는 4자리 이상이어야 합니다.")
            $('#chkMsg').css({"color":"red","font-size":"13px"});
            return;
        }

        $.ajax({
            url: "<c:url value='memberIdCheck.do'/>",
            type: "get",
            data: {"uid": uid}, // 서버에 전송 할 데이터
            success: function (responseData) {

                //responseData = "yes" or "no", yes: 사용가능 no: 사용불가
                if (responseData == "yes") {
                    $('#chkMsg').html("사용가능한 아이디 입니다.");
                    $('#chkMsg').css({"color":"blue","font-size":"13px"});
                    $('#isIdChk').val("yes");
                } else {
                    $('#chkMsg').html("사용불가한 아이디 입니다.")
                    $('#chkMsg').css({"color":"red","font-size":"13px"});

                }// if문


            },
            //success

            error: function () {
                $('#chkMsg').html("네트웍 에러")
                $('#chkModal').modal("show");
            }

        }); // $.ajax


    }//funtion idCheck


    function emailCheck() {
        let uEmail = $("#email").val();
        $.ajax({
            url: "<c:url value='memberEmailCheck.do'/>",
            type: "get",
            data: {"uEmail": uEmail},
            success: function (uuid) {
                if (uuid != "fail") {

                    serverUUID = uuid;
                    console.log("이메일 인증코드 : " + uuid);
                    $("#confirmEmail").html('    <div class="col-md-8">'
                        + '<input class="form-control mb-2" type="text" id="confirmUUID">'
                        + ' </div>'
                        + ' <div class="col-md-4">'
                        + ' <span class="btn btn-outline-secondary" onclick="emailConfirm()">인증코드확인</span>'
                        + '</div>'
                    );
                }else{
                    alert("이메일을 다시 확인하세요");
                    $("#email").select();
                }


            },
            error: function () {
                alert("이메일 인증 실패!!");
            }
        });
    }//emailCheck( );

    function emailConfirm(){
        let confrimUUID = $("#confirmUUID").val();

        if(confrimUUID == null || confrimUUID ==""){
            alert("인증코드를 확인하세여");
            $("#confrimUUID").select();
        }else if(serverUUID == confrimUUID){
            alert("인증성공")
            isEmailChk = true;
        }else {
            alert("인증번호를 확인하세요")
            $("#confirmUUID").select();
            return;
        }
    }

</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/zipcode.js"></script>

</body>
</html>