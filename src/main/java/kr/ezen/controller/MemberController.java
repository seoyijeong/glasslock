package kr.ezen.controller;

import java.util.List;
import java.util.UUID;

import kr.ezen.bbs.domain.MemberDTO;
import kr.ezen.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*        두 개의 리턴의 차이점은 첫 번째는 뷰 이름을 반환하는 반면, 두 번째는 리디렉션을 반환한다는 것입니다.
        첫 번째 리턴인 "member/memberRegister"는 프레임워크에게 member/memberRegister 뷰를 렌더링하라고 지시합니다.
        이 뷰는 회원 가입 양식을 표시하는 역할을 합니다.
        두 번째 리턴인 "redirect:/member/memberList.do"는 프레임워크에게 사용자를 /member/memberList.do URL로 리디렉션하라고 지시합니다.
        이 URL은 회원 목록을 표시하는 역할을 합니다.
        뷰와 리디렉션의 차이점은 뷰는 페이지를 렌더링하는 반면, 리디렉션은 단순히 사용자를 다른 URL로 보낸다는 것입니다.
        이 경우, 첫 번째 리턴은 회원 가입 양식을 렌더링하는 데 사용되고, 두 번째 리턴은 회원이 등록된 후 사용자를 회원 목록으로 리디렉션하는 데 사용됩니다.*/



@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private MemberService service;

    @RequestMapping("/memberList.do")
    public String memberList(Model model) {
        //list에 담아서 전송할때는 model로 묶어서 전달.
//		List<MemberDTO> memberList = dao.memberList();
        List<MemberDTO> memberList = service.memberList();
        model.addAttribute("list", memberList);

        return "member/memberList";
    }

    @RequestMapping("/memberRegister.do")
    public String memberRegister() {

        return "member/memberRegister";
    }

    @RequestMapping("/memberInsert.do")
    public String memberInsert(MemberDTO dto) {
//		dao.memberInsert(dto);
        service.memberRegister(dto);

        return "redirect:/member/memberList.do";
    }

    @RequestMapping("/memberInfo.do")
    public String memberInfo(int no, Model model) {
//		MemberDTO dto = dao.memberInfo(no);
        MemberDTO dto = service.memberInfo(no);

        model.addAttribute("dto", dto);
        return "/member/memberInfo";
    }

    @RequestMapping("/memberUpdate.do")
    public String memberUpdate(MemberDTO dto) {
        service.memberModify(dto);

        return "redirect:/member/memberList.do";
    }

    @RequestMapping("/memberDelete.do")
    public String memberDelete(int no) {
//		dao.deleteMember(no);
        service.memberRemove(no);

        return "redirect:/member/memberList.do";
    }

    // Message Converter API : jackson
    // ==> JSON 형식 자바객체로 변환, 또는 그 반대 변환

    // 비동기 전송데이터는 HTTP MSG의 body 담아서 전송한다.

    // @ResponseBody : 서버에서 클라이언트에 응답할 때, 자바객체를 HTTP 응답 MSG body에 변환해서
    // 클라이언트에 전송

    // @RequestBody : 클라이언트에서 서버로 데이터를 보낼때, HTTP 요청 MSG의 body에 담긴 값을
    // 자바객체로 변환해서 전송

    // 최근에는 주로 JSON형식, 예전에는 XML형식

    @RequestMapping("/memberAjaxList.do")
    public @ResponseBody List<MemberDTO> memberAjaxList() {
        List<MemberDTO> memberList = service.memberList();
        return memberList;
    }

    @RequestMapping("/memberIdCheck.do")
    public @ResponseBody String memberIdCheck(@RequestParam("uid") String uid) {
        MemberDTO dto = service.idCheck(uid);
        if (dto != null || "".equals(uid.trim())) {
            return "no";
        }

        return "yes";
    }

    /*ajax 는 responseBody로 데이터를 담음*/
    @RequestMapping("/memberEmailCheck.do")
    @ResponseBody
    public String emailCheck(@RequestParam("uEmail") String uEmail) {
        System.out.println("uEmail: " + uEmail);

        //인증 코드 생성
        //자바에서 제공해주는 UUID가 랜덤으로 생성(32자리),6자리로 자르기
        String uuid = UUID.randomUUID().toString().substring(0, 6);
        System.out.println("uuid: " + uuid);

        //mime 타입으로 mailSender 연결
        MimeMessage mail = mailSender.createMimeMessage();

        //내용을 넣어 메일 보내기(사용자 인증 코드)
        String mailContents = "<h3>이메일 주소 확인</h3></br>" +
                "<span>사용자가 본인임을 확인하려고 합니다. 다음 확인 코드를 입력하세요</span>"
                + "<h2>" + uuid + "</h2>";
        //메일 컨텐츠,예외처리
        try {
            mail.setSubject("jh아카데미 [이메일 인증]", "utf-8");
            mail.setText(mailContents, "utf-8", "html");

            // 상대방 메일 셋팅(수신자정하기)
            mail.addRecipient(Message.RecipientType.TO, new InternetAddress(uEmail));

            //메일 보내기
            mailSender.send(mail);

            return uuid;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "fail";

    }
    //1. login.do 요청
    //2. loginFrom 이동
    //3. <form action="<c:url value="login.do"/>" method="post">
    // post 방식으로 login.do 요청

    @GetMapping("login.do")
    /*view 로그인 */
    public String loginForm() {
        return "login/loginForm";
    }

    /*service,mapper 등 연결*/
    @PostMapping("login.do")
    public String memberLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes rttr) {
        boolean result = service.memberLogin(dto, req);
        if (!result) { //로그인 실패
            rttr.addAttribute("result", 0); //->실패시 다시 로그인 폼으로 이동
            return "redirect:/member/login.do";  //redirect는 get방식
        }
        return "redirect:/member/memberList.do";
    }

    //링크로 타고 들어가면 get방식
    @GetMapping("/logout.do")
    //세션을 직접 만든다
    public String memberlogout(HttpSession session) {
        session.invalidate(); //세션 초기화
        return "redirect:/";
    }

    @GetMapping("/idPwFind.do")
    public String idPwFind(String find, Model m) {
        m.addAttribute("find", find);

        return "login/idPwFind";

    }

    @PostMapping("/findId.do")
    //ajax로 넘어감
    @ResponseBody
    public String findId(MemberDTO dto) {
        System.out.println("dto.getTel() = " + dto.getTel());
        System.out.println("dto.getTel() = " + dto.getName());
        String resultId = service.findId(dto);
        System.out.println("resultId = " + resultId);

        return resultId;
    }

    @PostMapping("findPw.do")
    @ResponseBody
    public int findPw(String uid, String uEmail) {
        int n = service.findPw(uid, uEmail);
        System.out.println("n = " + n);
        return n;
    }

    @GetMapping("/myProfile.do")
    public String myProfile() {
        return "member/myProfile";
    }

    @PostMapping("/pwCheck.do")
    //data:{"pw": pw}, 전송된 데이터 받음
    //저장된 세션으로 받음
    @ResponseBody //ajax 요청 //view로 넘어가지 않고 자바 스크립트로 넘어감(데이터가 body로 넘어감)
    public String pwCheck(String pw, HttpSession session) {
        System.out.println("입력된 pw :" + pw);
        String chkResult = "";
        MemberDTO dto = (MemberDTO) session.getAttribute("loginDTO");
        String dbPw = dto.getPw();

        if (dbPw.equals(pw)) {
            chkResult = "ok";
        } else {
            chkResult = "no";
        }
        return chkResult;  //값이 변수로 넘어감
    }

    @PostMapping("pwChange.do")
    @ResponseBody
    //json 객체를 받아올 때
    public int pwChange(@RequestBody MemberDTO dto) {
        int n = service.modifyPw(dto);
        return n;
    }
}
