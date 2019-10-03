package study.spring.springboot.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import study.spring.springboot.helper.WebHelper;



@Configuration
@ComponentScan(basePackages = "study.spring.springboot.helper")
@MapperScan(basePackages = "study.spring.springboot.Mapper")
public class MyBatisConfig {
	
	 	@Bean
	    public SqlSessionFactory sqlSessionFactory (DataSource dataSource) throws Exception {
	        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
	        
	        sqlSessionFactory.setDataSource(dataSource);
	        sqlSessionFactory.setTypeAliasesPackage("classpath:/mapper/*.xml");
	        
	        return sqlSessionFactory.getObject();
	    }
	    
	    @Bean
	    public SqlSessionTemplate sqlSession (SqlSessionFactory sqlSessionFactory) {
	        
	        return new SqlSessionTemplate(sqlSessionFactory);
	    }
	    
	    @Value("UTF-8")
	    private String encType;
	    
	    @Value("localhost")
	    private String domain;
	  
	    @Bean
	    public WebHelper webHelper() {
	    	WebHelper webHelper = new WebHelper();
	    	webHelper.setEncType(encType);
	    	webHelper.setDomain(domain);
	    	
	    	return new WebHelper();
	    }
	    

}
