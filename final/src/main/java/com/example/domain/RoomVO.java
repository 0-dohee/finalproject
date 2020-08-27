package com.example.domain;

import java.util.List;

public class RoomVO{
	private String r_id;
	private String r_roomnum;
	private String r_title;
	private String r_detail;
	private int r_persons;
	private String r_image;
	private	int r_price;
	private double r_grade;
	private String r_status;
	private List<String> images;

	private String r_i_id;
	private String r_i_roomnum;
	private String r_i_images;
	
	private String r_o_id;
	private String r_o_roomnum;
	private String r_o_option;
	
	private String r;
	

	
	public String getR() {
		return r;
	}
	public void setR(String r) {
		this.r = r;
	}
	public String getR_o_id() {
		return r_o_id;
	}
	public void setR_o_id(String r_o_id) {
		this.r_o_id = r_o_id;
	}
	public String getR_o_roomnum() {
		return r_o_roomnum;
	}
	public void setR_o_roomnum(String r_o_roomnum) {
		this.r_o_roomnum = r_o_roomnum;
	}
	public String getR_o_option() {
		return r_o_option;
	}
	public void setR_o_option(String r_o_option) {
		this.r_o_option = r_o_option;
	}
	public String getR_i_id() {
		return r_i_id;
	}
	public void setR_i_id(String r_i_id) {
		this.r_i_id = r_i_id;
	}
	public String getR_i_roomnum() {
		return r_i_roomnum;
	}
	public void setR_i_roomnum(String r_i_roomnum) {
		this.r_i_roomnum = r_i_roomnum;
	}
	public String getR_i_images() {
		return r_i_images;
	}
	public void setR_i_images(String r_i_images) {
		this.r_i_images = r_i_images;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public String getR_roomnum() {
		return r_roomnum;
	}
	public void setR_roomnum(String r_roomnum) {
		this.r_roomnum = r_roomnum;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_detail() {
		return r_detail;
	}
	public void setR_detail(String r_detail) {
		this.r_detail = r_detail;
	}
	public int getR_persons() {
		return r_persons;
	}
	public void setR_persons(int r_persons) {
		this.r_persons = r_persons;
	}
	public String getR_image() {
		return r_image;
	}
	public void setR_image(String r_image) {
		this.r_image = r_image;
	}
	public int getR_price() {
		return r_price;
	}
	public void setR_price(int r_price) {
		this.r_price = r_price;
	}
	public double getR_grade() {
		return r_grade;
	}
	public void setR_grade(double r_grade) {
		this.r_grade = r_grade;
	}
	public String getR_status() {
		return r_status;
	}
	public void setR_status(String r_status) {
		this.r_status = r_status;
	}
	public List<String> getImages() {
		return images;
	}
	public void setImages(List<String> images) {
		this.images = images;
	}
	@Override
	public String toString() {
		return "RoomVO [r_id=" + r_id + ", r_roomnum=" + r_roomnum + ", r_title=" + r_title + ", r_detail=" + r_detail
				+ ", r_persons=" + r_persons + ", r_image=" + r_image + ", r_price=" + r_price + ", r_grade=" + r_grade
				+ ", r_status=" + r_status + ", images=" + images + ", r_i_id=" + r_i_id + ", r_i_roomnum="
				+ r_i_roomnum + ", r_i_images=" + r_i_images + ", r_o_id=" + r_o_id + ", r_o_roomnum=" + r_o_roomnum
				+ ", r_o_option=" + r_o_option + ", r=" + r + "]";
	}

	
	
}
