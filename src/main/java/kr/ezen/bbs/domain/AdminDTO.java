package kr.ezen.bbs.domain;

import lombok.Data;

@Data
public class AdminDTO {
    private String id;
    private String password;
    private String name;
    private String email;
}
