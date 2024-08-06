package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.domain.Score;
import com.sp.app.mapper.ScoreMapper;

@Service
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private ScoreMapper mapper;

	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			mapper.insertScore(dto);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			mapper.updateScore(dto);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			mapper.deleteScore(hak);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}

	@Override
	public void deleteScore(List<String> list) throws Exception {
		try {
			mapper.deleteListScore(list);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list = null;
		try {
			list = mapper.listScore(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Score> listScore() {
		List<Score> list = null;
		try {
			list = mapper.findByAll();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public Score findById(String hak) {
		Score dto = null;
		try {
			dto = mapper.findById(hak);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

}
