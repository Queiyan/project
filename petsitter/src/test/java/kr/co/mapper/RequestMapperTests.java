package kr.co.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.domain.SitterInfoVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RequestMapperTests {
	@Setter(onMethod_ = @Autowired)
	private SitterInfoMapper mapper;
//	@Test
//	public void testGetList() {
//		SitterInfoVO vo = null;
//		vo.setSitter("123");
//		vo.setMno(1);
//		log.info(mapper.select("123"));
//	}
	
//	@Test
//	public void test() {
//		log.info(mapper.getCount("123"));
//	}
	
	@Test
	public void test() {
		log.info(mapper.getAvg("123"));
	}


}
