<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/adminHeader.jsp" %>

<%--onkeyup은 사용자가 키보드의 키를 놓을 때 발생하는 이벤트입니다.
이 이벤트는 웹 페이지에서 키보드 입력을 처리하는 데 사용할 수 있습니다. 예를 들어, 사용자가 키보드의 A 키를 누르면 onkeyup 이벤트가 발생합니다.
이 이벤트를 사용하여 사용자가 A 키를 눌렀는지 확인하고, 이 이벤트가 발생할 때 수행할 작업을 지정할 수 있습니다.--%>
<div class="container w-50 mt-5 p-5 shadow">

<h4>카테고리 등록</h4>

    <%--name="cat_inputFrm" 스크립트에서 사용하기 위한 이름 지정--%>
   <form action="<c:url value="/admin/insertCategory.do"/>" method="post" name="cate_inputForm">
      <label for="code">카테고리 코드</label>
      <input class="form-control" type="text" id="code" name="code" onkeyup="inputlen()" placeholder="코드를 입력하세요" autofocus>
      <p id="chkMsg"></p>
      <label for="catName">카테고리 명</label>
      <input class="form-control mt-2" type="text" id="catName" name="catName" onkeyup="inputlen2()" placeholder="카테고리명을 입력하세요">
      <p id="chkMsg2"></p>
      <div class="text-center mt-3">
         <%--등록할때 유효성 검사를 해야 맞을때만 등록--%>
         <%--버튼 방식으로 만들면 검사를 하지 않고 등록된다!!!!<button class="btn btn-primary" onclick="inputChk()">등록</button>--%>
            <%--input type="submit" :submit은 전송 버튼이기 때문에 유효성 검사를 해도 넘어간다.--%>
            <input type="button" class="btn btn-primary btn-sm" onclick="inputChk()" value="등록"/>

      </div>
   </form>
</div>

<%--등록할때 유효성 검사를 해야 맞을때만 등록--%>
<script>
   function inputChk(){
      var code = $('#code').val();
      var catName = $('#catName').val();
      // code 값이 null이면 false지만
      // null 이면 실행되게 ! 을 이용해서 true로 바꿔준것
      if(!cate_inputForm.code.value){
         alert("카테고리 코드를 입력하세요.");
         cate_inputForm.code.focus();

         return;
      }
      if(!cate_inputForm.catName.value){
         alert("카테고리명을 입력하세요.");
         cate_inputForm.catName.focus();
         return;
      }
      document.cate_inputForm.submit();
   } //inputChk


   function inputlen(){

      var code = $('#code').val();

      if(code.length<2){
         $('#chkMsg').html("코드 길이는 2자리 이상이어야 합니다.")
         $('#chkMsg').css({"color":"red","font-size":"13px"});
         return;
      }else{
         $('#chkMsg').html("사용가능함.")
         $('#chkMsg').css({"color":"green","font-size":"13px"});
         return;
      };
   }//inputlen

   function inputlen2(){

      var catName = $('#catName').val();

      if(catName.length<3){
         $('#chkMsg2').html("카테고리 길이는 3자리 이상이어야 합니다.")
         $('#chkMsg2').css({"color":"red","font-size":"13px"});
         return;
      }else{
         $('#chkMsg2').html("사용가능함.")
         $('#chkMsg2').css({"color":"green","font-size":"13px"});
         return;
      }

   }


</script>

<jsp:include page="../inc/footer.jsp"/>