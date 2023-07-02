package kr.ezen.bbs.domain;

import lombok.Data;

@Data
public class ProductDTO {
    private int pnum;
    private String pname;
    /*다른키를 연결시키겟다 _fk*/
    private String pcategory_fk;
    private String pcompany;
    private String pimage;
    private int pqty;
    private int price;
    private String pspec;
    private String pcontent;
    private int ppoint;
    private String pinputDate;

    private int totalPrice;
    private int totalPoint;
}
