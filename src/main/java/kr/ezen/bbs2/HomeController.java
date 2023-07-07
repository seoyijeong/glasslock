package kr.ezen.bbs2;

import java.text.DateFormat;
import java.util.*;

import kr.ezen.bbs.domain.ProductDTO;
import kr.ezen.bbs.util.ProdSpec;
import kr.ezen.service.ProductViewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private ProductViewService service;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );

		//model.addAttribute("msg", "상품이 없습니다");
		//enum 상수 가져오기
		ProdSpec[] pdSpecs = ProdSpec.values();

		model.addAttribute("pdSpecs", pdSpecs);

		Map map = new HashMap();

		for(ProdSpec pds : pdSpecs) {
			String pspec = pds.name();  //A01,B01...

			List<ProductDTO> list = service.pdSpecList(pspec);
			System.out.println(list);

			if(list.size() != 0) {
				map.put(pspec, list);
			}
		}

		for ( Object key : map.keySet() ) {
			System.out.println(" key : " + key +" / value : " + map.get(key));
		}
		System.out.println(map);
		System.out.println(pdSpecs);
		model.addAttribute("map", map);


		
		return "home";
	}


	
}
