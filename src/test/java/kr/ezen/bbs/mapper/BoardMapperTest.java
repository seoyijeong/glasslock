package kr.ezen.bbs.mapper;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.PageDTO;
import kr.ezen.config.RootConfig;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@Log4j
// 컨테이너 구동시켜줌..
@RunWith(SpringJUnit4ClassRunner.class)
// 컨테이너안에 DataSource 객체가 생성되야 테스트가 가능하기 때문에
@ContextConfiguration(classes = RootConfig.class)
public class BoardMapperTest {

    @Autowired
    BoardMapper mapper;

//    @Test
//    public void getList(){
//        PageDTO pDto = new PageDTO();
//        List<BoardDTO> list = mapper.getList(pDto);
//
//        for(BoardDTO dto : list){
//            System.out.println(dto);
//            log.info(dto);
//        }
//    }


}
