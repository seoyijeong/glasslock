package kr.ezen.bbs.mapper;

import java.util.List;

import kr.ezen.bbs.domain.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.Mergeable;


@Mapper
public interface MemberMapper {
	List<MemberDTO> memberList();

	int memberInsert(MemberDTO dto);

	int memberDelete(int no);

	MemberDTO memberInfo(int no);

	int memberUpdate(MemberDTO dto);

	MemberDTO idCheck(String uid);

	MemberDTO memberLogin(MemberDTO dto);

	String findId(MemberDTO dto);

	int findPw(String uid, String uEmail, String tempPw);

	int updatePw(MemberDTO dto);
}
