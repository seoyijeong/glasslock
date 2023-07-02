package kr.ezen.bbs.domain;

import java.sql.Date;

import lombok.Data;

//<typeAlias type="kr.ezen.bbs.domain.AdminDTO" alias="adminDTO"/>
//dto는 컨피그 alias 연결 필수!!!!


//@Setter @Getter @ToString
@Data
public class BoardDTO {
	private int bid;
	private String subject;
	private String contents;
	private int hit;
	private String writer;
	private Date reg_date;
}
