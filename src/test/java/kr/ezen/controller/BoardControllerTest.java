package kr.ezen.controller;

import kr.ezen.config.RootConfig;
import kr.ezen.config.ServletConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

import static org.junit.Assert.*;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // ServletContext 사용하기 위한 어노테이션
@ContextConfiguration(classes = {RootConfig.class, ServletConfig.class})
public class BoardControllerTest {

    @Autowired
    private WebApplicationContext ctx;

    private MockMvc mockMvc; // 가상의 MVC 환경을 제공하는 객체

    // 가상의 MVC 환경을 만들어줌
    @Before // @Test보다 먼저 수행되는 어노테이션
    public void setup(){
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void list() throws Exception{
        // PageDTO pDto = new PageDTO();
        MultiValueMap<String, String> p = new LinkedMultiValueMap<>();
        p.add("viewPage", "1");
        p.add("cntPerPage", "10");
//        p.add("searchType", "S");
//        p.add("keyWord", "테스트");

        log.info(
          mockMvc.perform(MockMvcRequestBuilders.get("/board/list.do").param(""))
                  .andReturn()
                  . getModelAndView().getViewName()
        );
    }
}