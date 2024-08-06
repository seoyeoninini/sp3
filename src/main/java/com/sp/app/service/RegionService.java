package com.sp.app.service;

import java.util.List;

import com.sp.app.domain.Region;

public interface RegionService {
	public List<Region> listRegion();
	public List<Region> listRegion(String keyword);
}
