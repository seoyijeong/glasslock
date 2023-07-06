package kr.ezen.bbs.mapper;

import kr.ezen.bbs.domain.AdminDTO;
import kr.ezen.bbs.domain.CategoryDTO;
import kr.ezen.bbs.domain.ProductDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;


@Mapper
public interface AdminMapper {


	AdminDTO adminLogin(AdminDTO dto);

	int insertCategory(CategoryDTO cDto);


    List<CategoryDTO> listCategory();


    int categoryDelete(int catNum);

    void productInsert(Map map);

    List<ProductDTO> productList();

    int productUpdate(Map map);

    ProductDTO prodInfo(int pnum);

    int prodDelete(int pnum);

    // 상품 등록시 서비스단에선 void로 하고 컨트롤러에서 String으로
    
}
