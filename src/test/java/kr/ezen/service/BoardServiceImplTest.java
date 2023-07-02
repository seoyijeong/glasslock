package kr.ezen.service;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.PageDTO;
import kr.ezen.config.RootConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
public class BoardServiceImplTest {

    @Autowired
    BoardService bs;


    @Test
    public void getList() {
        PageDTO pDto = new PageDTO();

        List<BoardDTO> list = bs.getList(pDto);

//        for(BoardDTO dto : list){
//            log.info(dto);
//        }

        bs.getList(pDto).forEach(boardDTO -> log.info(boardDTO));

    }

    @Test
    public void view(){
        BoardDTO boardDTO = bs.view(129, "v");
        System.out.println("boardDTO = " + boardDTO);
        assertTrue(boardDTO.getBid() == 129);
    }
}