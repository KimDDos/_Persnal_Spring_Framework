package com.springproject.www.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// Root-context.xml 파일을 대체해서 설정하는 부분
		return new Class[] {RootConfig.class, SecurityConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// Servlet-Context.xml 파일을 대체
		return new Class[] {ServletConfiguration.class};
	}

	@Override
	protected String[] getServletMappings() {
		// Servlet-Mapping 파일을 대체하여 설정하는 부분
		return new String[] {"/"};
	}


	// Encoding Filter 추가
	@Override
	protected Filter[] getServletFilters() {
		// filter 설정
		CharacterEncodingFilter encoding = new CharacterEncodingFilter();
		encoding.setEncoding("UTF-8");
		encoding.setForceEncoding(true);
		
		return new Filter[] {encoding};
		// return new Filter[] {encoding, 000 ,  0000};
		// 이렇게 여러가지 필터를 붙일수도 있음!
	}
	
	@Override
	protected void customizeRegistration(Dynamic registration) {
		// 사용자 지정 익셉션 설정을 할 것인지 처리 throwExceptionIfNoHandlerFound
		// 파일 업로드 할때 설정할 예정
		// C:\Users\DoYeon Kim\Desktop\Gookbi\_Persnal_Spring_Framework\_mySpringProject\_java
		String uploadLocation = "C:\\Users\\DoYeon Kim\\Desktop\\Gookbi\\_Persnal_Spring_Framework\\_mySpringProject\\_java";
		int maxFileSize = 1024*1024*20;
		int maxReqSize = maxFileSize * 2;
		int fileSizeThreshold = maxReqSize;
		
		MultipartConfigElement multipartConfig = new MultipartConfigElement(uploadLocation, maxFileSize, maxReqSize, fileSizeThreshold);
		registration.setMultipartConfig(multipartConfig);
	}
	
	
}
