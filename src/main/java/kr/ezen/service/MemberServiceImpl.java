package kr.ezen.service;

import kr.ezen.bbs.domain.MemberDTO;
import kr.ezen.bbs.mapper.BoardMapper;
import kr.ezen.bbs.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper mapper;

	@Autowired
	JavaMailSender mailSender;

	@Override
	//리턴 받지 않고 그대로 mapper에 전달
	public List<MemberDTO> memberList() {
		return mapper.memberList();
	}

	@Override
	public int memberRegister(MemberDTO dto) {
		return mapper.memberInsert(dto);
	}

	@Override
	public int memberRemove(int no) {
		return mapper.memberDelete(no);
	}

	@Override
	public MemberDTO memberInfo(int no) {
		return mapper.memberInfo(no);
	}

	@Override
	public int memberModify(MemberDTO dto) {
		return mapper.memberUpdate(dto);
	}

	@Override
	public MemberDTO idCheck(String uid) {
		return mapper.idCheck(uid);
	}


	/*dto를 service로 넘김*/
	@Override
	public boolean memberLogin(MemberDTO dto, HttpServletRequest req) {
		//비번이 일치하는 경우 세션에 담음
		HttpSession session = req.getSession();
		//아이디와 일치하는 회원정보를 DTO에 담아서 가져옴
		MemberDTO loginDTO= mapper.memberLogin(dto);

		if(loginDTO != null) { //일치하는 아이디가 있는 경우
			//사용자가 입력한 비번과 db 비번이 일치하는지
			String inputPw = dto.getPw();  //사용자가 입력한 비번
			String dbPw = loginDTO.getPw(); //db에서 불러온 비번
			if(inputPw.equals(dbPw)){ //비번일치
				session.setAttribute("loginDTO", loginDTO);   //비번 일치시 세션에 저장
				return true;
			}else {  //비번 불일치
				return false;
			}
		}
		//로그인이 되면 세션 정보에 저장해야함
		//세션을 만드려면(HttpServlet 매개변수로 지정)
		return false;
	}

	@Override
	public String findId(MemberDTO dto) {
		String resultId= mapper.findId(dto);
		return resultId;
	}

	//mailSender가 현재 config에 위치 ->webconfig에 넣음

	@Override
	public int findPw(String uid, String uEmail) {
		//임시 비밀번호 만들기
		String tempPw = UUID.randomUUID().toString().substring(0, 6);
		//메일로 메시지 보내기
		MimeMessage mail = mailSender.createMimeMessage();
		String mailContents =
				"<h3>임시 비밀먼호 발급</h3></br>"
						+"<h2>"+tempPw+"</h2>"
						+"<p>로그인후 마이페이지 에서 비밀번호를 변경해 주세요</p>";

		try {
			mail.setSubject("jh아카데미 [임시비밀번호]", "utf-8");
			mail.setText(mailContents, "utf-8", "html");

			// 사용자가 입력한 값 받기
			mail.addRecipient(Message.RecipientType.TO, new InternetAddress(uEmail));

			mailSender.send(mail);

		} catch (Exception e) {
			e.printStackTrace();
		}
		//dto. 와 임시 비번 넘기기
		//dto(db) 와 tempPw(db아님)를 같이 넘길수 없음
		int n = mapper.findPw(uid, uEmail, tempPw);
		System.out.println("tempPw = " + tempPw);
		return n;
	}

	@Override
	public int modifyPw(MemberDTO dto) {
		int n = mapper.updatePw(dto);
		return n;
	}
}
