package kr.ezen.service;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.MemberDTO;
import kr.ezen.bbs.domain.PageDTO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface MemberService {
    //추상 메서드
    List<MemberDTO> memberList();

    int memberRegister(MemberDTO dto);

    int memberRemove(int no);

    MemberDTO memberInfo(int no);

    int memberModify(MemberDTO dto);

    MemberDTO idCheck(String uid);

    boolean memberLogin(MemberDTO dto, HttpServletRequest req);

    String findId(MemberDTO dto);

    int findPw(String uid, String uEmail);

    int modifyPw(MemberDTO dto);
}










