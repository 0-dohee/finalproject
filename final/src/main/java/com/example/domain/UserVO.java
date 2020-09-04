package com.example.domain;

public class UserVO {
	private String u_id;
	private String u_k_id;
	private String u_pass;
	private String u_name;
	private String u_tel;
	private String u_address;
	private String u_email;
	private String u_image;
	private String u_status;
	private String u_birthday;
	private String u_key;
	private String u_gender;
	public String getU_k_id() {
		return u_k_id;
	}
	public void setU_k_id(String u_k_id) {
		this.u_k_id = u_k_id;
	}
	public String getU_gender() {
		return u_gender;
	}
	public void setU_gender(String u_gender) {
		this.u_gender = u_gender;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pass() {
		return u_pass;
	}
	public void setU_pass(String u_pass) {
		this.u_pass = u_pass;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_tel() {
		return u_tel;
	}
	public void setU_tel(String u_tel) {
		this.u_tel = u_tel;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_image() {
		return u_image;
	}
	public void setU_image(String u_image) {
		this.u_image = u_image;
	}
	public String getU_status() {
		return u_status;
	}
	public void setU_status(String u_status) {
		this.u_status = u_status;
	}
	public String getU_birthday() {
		return u_birthday;
	}
	public void setU_birthday(String u_birthday) {
		this.u_birthday = u_birthday;
	}
	public String getU_key() {
		return u_key;
	}
	public void setU_key(String u_key) {
		this.u_key = u_key;
	}
	@Override
	public String toString() {
		return "UserVO [u_id=" + u_id + ", u_k_id=" + u_k_id + ", u_pass=" + u_pass + ", u_name=" + u_name + ", u_tel="
				+ u_tel + ", u_address=" + u_address + ", u_email=" + u_email + ", u_image=" + u_image + ", u_status="
				+ u_status + ", u_birthday=" + u_birthday + ", u_key=" + u_key + ", u_gender=" + u_gender + "]";
	}
	
	
	
}
