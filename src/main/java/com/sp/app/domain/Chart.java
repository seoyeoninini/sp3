package com.sp.app.domain;

public class Chart {
	private String title;
	private double value;
	
	public Chart() {
	}

	public Chart(String title, double value) {
		this.title = title;
		this.value = value;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	}
	
}
