package kr.ezen.service;

import kr.ezen.bbs.domain.CategoryDTO;
import kr.ezen.bbs.domain.ProductDTO;
import kr.ezen.bbs.mapper.ProductViewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class ProductViewServiceImpl implements ProductViewService {

	@Autowired
	ProductViewMapper mapper;

//	@Override
//	public HashMap<String, ArrayList<ProductDTO>> map() {
//
//		ArrayList<CategoryDTO> categoryList = mapper.categoryList();
//		ArrayList<ProductDTO> productList = mapper.productList(categoryList);
//
//	// 상품 사양별로 해시맵에 추가하기
//	/*		map().put(pSpec, list);*/
//		return null;
//	}

	@Override
	public List<ProductDTO> pdSpecList(String pspec) {
		return mapper.pdSpecList(pspec);
	}

}
