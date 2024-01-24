package com.springproject.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@EnableWebMvc
@ComponentScan(basePackages = {"com.springproject.www.controller", "com.springproject.www.handler"})
public class ServletConfiguration implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// resources 경로 설정
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		// FileUpload 경로 설정
		registry.addResourceHandler("/upload/**").addResourceLocations("C:\\Users\\DoYeon Kim\\Desktop\\Gookbi\\_mySpringProject\\_java\\_Upload");
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// 뷰 경로 설정 (InternalResourceViewResolver 설정)
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setViewClass(JstlView.class);
		
		registry.viewResolver(viewResolver);
	}

	// multipartResolver 설정 (파일 할때 추가)
	// 빈 이름이 반드시 multipartResolver 이여야하는데, 메서드명은 get을 써야하기에 name으로 따로 명시 해줘야함!
	// multipartResolver 이여야만 함!
	@Bean(name = "multipartResolver")
	public MultipartResolver getMultipartResolver() {
		StandardServletMultipartResolver multipartResolver = new StandardServletMultipartResolver();
		return multipartResolver;
	}
	
}
