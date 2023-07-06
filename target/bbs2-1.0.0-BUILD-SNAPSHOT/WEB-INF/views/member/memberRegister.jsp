<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@ include file="../inc/header.jsp" %>
<%--
<style>
    input[type='date']::before{
        content: attr(data-placeholder);
        width: 100%;
        color: #666;
    }
    input[type='date']:valid::before{
        display: none;
    }
--%>

</style>
<div class="container w-50 shadow rounded border p-5 mt-5">
    <form action="<c:url value="memberInsert.do"/>" method="post" onsubmit="return submitChk()">
        <h3 class="text-center mb-4">회원가입</h3>
        <div class="row">
            <%--				<div class="col-md-8 pe-0">--%>
            <%--					<input class="form-control mb-2" type="text" id="id" name="id" placeholder="아이디"/>--%>
            <%--				</div>--%>
            <%--				<div class="col-md-4">--%>
            <%--					<a class="btn btn-outline-warning w-100" onclick="idCheck()">아이디 중복체크</a>--%>
            <%--				</div>--%>

            <input class="form-control mb-2" onkeyup="idCheck()" type="text" id="id" name="id" placeholder="아이디"/>
            <p id="chkMsg" class="mb-2"></p>

            <input type="hidden" id="isIdChk" value="no"/>



        </div>
        <input class="form-control mb-2" type="text" name="pw" placeholder="비밀번호"/>
        <input class="form-control mb-2" type="text" name="name" placeholder="이름"/>
        			<input class="form-control mb-2" type="text" name="age" placeholder="나이"/>
<%--        <input class="form-control mb-2" type="date" id="birthday" name="birthday" min="1990-01-01" max="2022-12-31"
               data-placeholder="생년월일" required/>--%>

        <input class="form-control mb-2" type="text" name="tel" placeholder="전화번호"/>

        <div class="row mb-2">
            <div class="col-md-8">
                <input type="text"  class="form-control" id="email" name="email" placeholder="이메일"/>
            </div>
            <div class="col-md-4">
                <span class="btn btn-outline-secondary w-100" onclick="emailCheck()"> 인증하기</span>
            </div>
        </div>
        <%-- 이메일 인증코드 확인하기 --%>
        <div class="row" id="confirmEmail">

        </div>


        <div class="row mb-2">
            <div class="col-md-4 col-sm-6">
                <input class="form-control" type="text" id="sample2_postcode" name="zipcode" placeholder="우편번호"/>
            </div>
            <div class="col-md-8 col-sm-6">
                <a class="btn btn-outline-secondary" onclick="sample2_execDaumPostcode()">우편번호 찾기</a>
            </div>
        </div>

        <input class="form-control mb-2" type="text" id="sample2_address" placeholder="도로명주소" name="road_addr"/>
        <input class="form-control mb-2" type="text" id="jibunAddress" placeholder="지번주소" name="detail_addr"/>
        <input class="form-control" type="text" id="sample2_detailAddress" placeholder="상세주소" name="detail_addr"/>

        <div class="text-center pt-4">
            <input type="submit" class="btn btn-primary" value="가입"/>
            <input type="reset" value="취소" class="btn btn-warning"/>
            <a href="<c:url value="memberList.do" />" class="btn btn-info">리스트</a>
        </div>
    </form>
    <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
    <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>
</div>

<!-- 아이디 중복체크 Modal -->
<div class="modal fade" id="chkModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <%--      Modal Header--%>
            <div class="modal-header">
                <h4 class="modal-title">중복체크 확인</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <%--      Modal body--%>
            <div class="modal-body text-center" id="chkMsg"></div>

            <%--      Modal footer--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
            </div>

        </div>
    </div>
</div>


<script>
    function submitChk(){
        let isIdChk = $("#isIdChk").val();
        console.log("isIdChk : " + isIdChk);
        if(isIdChk == "no"){
            alert("아이디 중복체크를 확인해주세요!!");
            $("#id").select();
            return false;
        }

        if(!isEmailChk){
            alert("이메일 인증 확인을 해주세요!!");
            $("#email").select();
            return false;
        }
    }

    function idCheck(){
        var uid = $("#id").val();

        if(uid.length<3){
            $("#chkMsg").html("아이디 길이는 3자리 이상이어야 합니다.")
            $("#chkMsg").css({"color":"red", "font-size":"13px"});
            return;
        }

        $.ajax({
            url:"<c:url value='memberIdCheck.do'/>",
            type: "get",
            data:{"uid":uid}, // 서버에 전송할 데이터
            success: function(responseData){
                // responseData = "yes" or "no", yes:사용가능 no:사용불가

                if(responseData == "yes"){
                    $("#chkMsg").html("사용가능한 아이디 입니다!!");
                    $("#chkMsg").css({"color":"blue", "font-size":"13px"});
                    $("#isIdChk").val("yes");
                }else{
                    $("#chkMsg").html("사용할 수 없는 아이디 입니다!!");
                    $("#chkMsg").css({"color":"red", "font-size":"13px"});
                }
                // $("#chkModal").modal("show");
            },
            error : function(){
                $("#chkMsg").html("서버 에러 입니다!!!");
                $("#chkModal").modal("show");
            }
        });



    }

    let serverUUID = "";
    let isEmailChk = false;
    function emailCheck(){
        let uEmail = $("#email").val();

        $.ajax({
            url:"<c:url value='memberEmailCheck.do'/>",
            type: "get",
            data: {"uEmail":uEmail},
            success: function(uuid){
                if(uuid != "fail"){
                    serverUUID = uuid;
                    console.log("이메일 인증코드 : " + uuid);
                    $("#confirmEmail").html('<div class="col-md-8">'
                        +'<input class="form-control mb-2" type="text" id="confirmUUID"/></div>'
                        +'<div class="col-md-4">'
                        +'<span class="btn btn-outline-secondary w-100" onclick="emailConfirm()"> 인증코드확인</span></div>'
                    );
                }else{
                    alert("이메일을 다시 확인하세요!!");
                    $("#email").select();
                }
            },
            error:function(){
                alert("인증 실패!!");
            }
        });
    }

    function emailConfirm(){
        let confirmUUID = $("#confirmUUID").val();

        if(confirmUUID == null || confirmUUID ==""){
            alert("인증 코드 확인하세요!!!");
            $("#confirmUUID").select();
        }else if(serverUUID == confirmUUID){
            alert("인증 성공!!");
            isEmailChk = true;
        }else{
            alert("인증코드를 다시 확인하세요!!");
            $("#confirmUUID").select();
            return;
        }
    }
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/zipcode.js"></script>

<jsp:include page="../inc/footer.jsp" />