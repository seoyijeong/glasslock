package kr.ezen.service;

import kr.ezen.bbs.domain.ProductDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ProductViewService {
//    HashMap<String, ArrayList<ProductDTO>> map();

    List<ProductDTO> pdSpecList(String pSpec);
}
