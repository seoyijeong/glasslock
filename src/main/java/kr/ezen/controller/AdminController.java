package kr.ezen.controller;

import kr.ezen.bbs.domain.*;
import kr.ezen.bbs.util.ProdSpec;
import kr.ezen.service.AdminService;
import kr.ezen.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService service;

    //관리자 로그인화면으로 이동
    /*adminLogin.do 페이지에서 로그인 폼으로 이동*/
    @GetMapping("/adminLogin.do")
    public String adminCheck() {
        return "admin/adminLoginForm";
    }

    @PostMapping("/adminLogin.do")
    public String adminLogin(AdminDTO dto, HttpServletRequest req, RedirectAttributes rttr) {
        boolean result = service.adminLogin(dto, req);
        if (!result) { //로그인 실패
            rttr.addAttribute("result", 0); //->실패시 다 시 로그인 폼으로이동
            return "redirect:/admin/adminLogin.do";  //redirect는 get방식
        }
        //jsp는 직접 view로 넘기는게 아니기 때문에 redirect불가
        return "/admin/ad_main";
    }

    //insertCategory.do 웹브라우저로 요청
    @GetMapping("/insertCategory.do")
    public String insertCategory() {

        //이동페이지 뷰.jsp
        return "/admin/cate_insert";
    }

    @PostMapping("/insertCategory.do")
    public String insertCategory(CategoryDTO cDto) {
        service.insertCategory(cDto);
        //저장한 값을 재요청 할때(jsp로 넘어가지 않고 맵핑주소로 입력)
        return "redirect:/admin/listCategory.do";
    }

    @RequestMapping("/listCategory.do")
    public String listCategory(Model model) {
        List<CategoryDTO> categoryList = service.listCategory();
        model.addAttribute("list", categoryList);

        return "admin/cate_list";
    }

    @GetMapping("/categoryDelete.do")
    public String categoryDelete(int catNum) {
        System.out.println("catNum = " + catNum);
        service.categoryRemove(catNum);

        return "redirect:/admin/listCategory.do";
    }

    //화면 구현창
    @GetMapping("/prodInput.do")
    public String insertProduct(Model model){
        List<CategoryDTO> categoryList = service.listCategory();
        model.addAttribute("list",categoryList);

        ProdSpec[] pdSpecs = ProdSpec.values();
        model.addAttribute("pdSpecs", pdSpecs);
        return "/admin/prod_input";
    }

    @PostMapping("/prodInput.do")
    public String prodInput(MultipartHttpServletRequest mhr){

        service.prodInput(mhr);
        return "redirect:/admin/productList.do";
    }
    @RequestMapping("/productList.do")
    public String productList(Model model) {
        //list에 담아서 전송할때는 model로 묶어서 전달.
//		List<MemberDTO> memberList = dao.memberList();
        List<ProductDTO> productList = service.productList();
        model.addAttribute("list", productList);

        return "admin/prod_list";
    }
    @GetMapping("/prodUpdate.do")
    public String productUpdate(Model model,int pnum){
        List<CategoryDTO> categoryList = service.listCategory();
        model.addAttribute("list",categoryList);

        ProductDTO dto = service.prodInfo(pnum);
        model.addAttribute("dto", dto);

        ProdSpec[] pdSpecs = ProdSpec.values();
        model.addAttribute("pdSpecs", pdSpecs);

        return "admin/prod_update";
    }
    @PostMapping("/prodUpdate.do")
    public String productUpdate(MultipartHttpServletRequest mhr){
        service.productModify(mhr);

        return "redirect:/admin/productList.do";
    }
    @GetMapping("/prodDelete.do")
    public String prodDelete(int pnum) {

        service.prodRemove(pnum);

        return "redirect:/admin/productList.do";
    }

}
