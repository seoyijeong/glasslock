package kr.ezen.service;

import kr.ezen.bbs.domain.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface AdminService {
    //추상 메서드
    boolean adminLogin(AdminDTO dto, HttpServletRequest req);
    int insertCategory(CategoryDTO cDto);

    List<CategoryDTO> listCategory();

    int categoryRemove(int catNum);

    // 상품만 등록하고 가져오지 않아도
    // 서비스단에선 void로 하고 컨트롤러에서 String으로
    //list를 불러오면 됨.
    void prodInput(MultipartHttpServletRequest mhr);

    List<ProductDTO> productList();

    int productModify(MultipartHttpServletRequest mhr);

    ProductDTO prodInfo(int pnum);

    int prodRemove(int pnum);
}




