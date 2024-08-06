package com.sp.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Demo;
import com.sp.app.mapper.DemoMapper;

@Service
public class DemoServiceImpl implements DemoService  {
	@Autowired
	private DemoMapper mapper;
	
	@Override
	public void insertDemo(Demo dto) throws Exception {
		try {
			mapper.insertDemo1(dto);
			mapper.insertDemo2(dto);
			mapper.insertDemo3(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

}
