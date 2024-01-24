package com.springproject.www.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;


@MapperScan(basePackages = {"com.springproject.www.repository"})
@ComponentScan(basePackages = {"com.springproject.www.service"})
@EnableTransactionManagement
@EnableScheduling
@Configuration
public class RootConfig {
	// DB 설정 부분
	// HikariCP 사용 / log4jdbc-log4j2
	
	@Autowired
	ApplicationContext applicationContext;
	// 애플리케이션의 빈들을 관리하고, 의존성 주입과 같은 스프링의 핵심 기능을 제공 
	// 이를 통해 필요한 다른 빈들이나 자원들을 사용할 수 있게 됩니다.
	
	@Bean
	public DataSource dataSource() {
		// 여기서 히카리 CP 사용
		HikariConfig hikariConfig = new HikariConfig();
		// log4jdbc-log4j2 를 사용해서
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/myspringdb");
		hikariConfig.setUsername("myspringUser");
		hikariConfig.setPassword("mysql");
		
		hikariConfig.setMaximumPoolSize(5);
		hikariConfig.setMinimumIdle(5);
		
		// cachePrepStmts : cache 사용 여부 설정
		hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");
		// why ? 캐시를 사용하면 동일한 쿼리를 여러번 실행할 때 이점이 있음
		
		hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSize", "250");
		// mysql 드라이버가 연결당 cache statement의 수에 관한 설정 : 250 ~ 500 사이 권장
		
		hikariConfig.addDataSourceProperty("dataSource.prepStmtCacheSqlLimit", "true");
		// connection 당 캐싱할 preparStatment의 개수 지정 옵션 : default 256 => true
		
		hikariConfig.addDataSourceProperty("dataSource.userServertPropStmts", "true");
		// mysql 서버에서 최신 이슈가 있을 경우 지원받을 설정
		
		HikariDataSource hakariDataSource = new HikariDataSource(hikariConfig);
		return hakariDataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlFactoryBean = new SqlSessionFactoryBean();
		
		sqlFactoryBean.setDataSource(dataSource());
		sqlFactoryBean.setMapperLocations(
				applicationContext.getResources("classpath:/mappers/*.xml"));
		sqlFactoryBean.setConfigLocation(
				applicationContext.getResource("classpath:/MybatisConfig.xml"));
		
		return sqlFactoryBean.getObject();
	}
	
	// 트랜잭션 매니져 빈 설정
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
}
