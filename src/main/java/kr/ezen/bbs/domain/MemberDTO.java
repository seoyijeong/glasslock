package kr.ezen.bbs.domain;

import lombok.Data;

@Data
public class MemberDTO {
	private int no;
	private String id;
	private String pw;
	private String name;
	private int age;
	private String email;
	private String tel;

	private String zipcode;
	private String road_addr;
	private String jibun_addr;
	private String detail_addr;

	public MemberDTO(String id, String pw, String name, int age, String email, String tel, String zipcode,
					 String road_addr, String jibun_addr, String detail_addr) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.tel = tel;
		this.zipcode = zipcode;
		this.road_addr = road_addr;
		this.jibun_addr = jibun_addr;
		this.detail_addr = detail_addr;
	}

	public MemberDTO(int no, String id, String pw, String name, int age, String email, String tel, String zipcode,
					 String road_addr, String jibun_addr, String detail_addr) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.tel = tel;
		this.zipcode = zipcode;
		this.road_addr = road_addr;
		this.jibun_addr = jibun_addr;
		this.detail_addr = detail_addr;
	}

	// 기본생성자
	public MemberDTO() {}

	// 인자 생성자
	public MemberDTO(int no, String id, String pw, String name, int age, String email, String tel) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.tel = tel;
	}
}