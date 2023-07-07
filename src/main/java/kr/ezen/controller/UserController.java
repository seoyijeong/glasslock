package kr.ezen.controller;

import kr.ezen.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/main")
public class UserController {

    @Autowired
    private AdminService service;



}
