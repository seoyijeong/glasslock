package kr.ezen.bbs.mapper;

import kr.ezen.bbs.domain.CategoryDTO;
import kr.ezen.bbs.domain.ProductDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;


@Mapper
public interface ProductViewMapper {


    ArrayList<CategoryDTO> categoryList();

    ArrayList<ProductDTO> productList(ArrayList<CategoryDTO> categoryList);

    List<ProductDTO> pdSpecList(String pspec);
}
