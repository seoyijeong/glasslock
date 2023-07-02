package kr.ezen.bbs.mapper;

import kr.ezen.config.RootConfig;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Log4j
// 컨테이너 구동시켜줌..
@RunWith(SpringJUnit4ClassRunner.class)
// 컨테이너안에 DataSource 객체가 생성되야 테스트가 가능하기 때문에
@ContextConfiguration(classes = RootConfig.class)
public class DataSourceTest {

    @Autowired
    private DataSource ds;

    @Test
    public void testConnection(){

        try (Connection conn = ds.getConnection()){
            log.info(conn);
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }
}
