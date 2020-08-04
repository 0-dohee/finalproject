package com.example.mapper;

import java.util.List;

import com.example.domain.CompanyVO;
import com.example.domain.UserVO;
import com.example.domain.UsertagVO;

public interface UserMapper {
	//ȸ������
	public void insert(UserVO vo);
	public void insertUsertag(String t_id, String t_tag);
	public void insertCompany(CompanyVO vo);
	public void delete(String u_id);
	public void deleteCompany(String c_id);
	
	public UserVO read(String u_id);
	public CompanyVO readCompany(String c_id);
	public String readid(String u_id);
	public String readcompanyid(String c_id);
	public String readcompanyNumber(String c_id);
	//ȸ������ �̸��� ����
	public int GetKey(String u_id, String u_key);
	public int alter_userKey(String u_id,String key);
	//��ü ȸ������ �̸��� ����
	public int GetKeyCompany(String c_id, String c_key);
	public int alter_KeyCompany(String c_id,String key);
	//ID/PW ã��
	public int checkName(String u_birthday, String u_name);
	public List<UserVO> checkID(String u_birthday, String u_name);
	public void updatePass(String u_id,String u_pass);
	//��ü ID/PW ã��
	public int checkNameCompany(String number, String name);
	public String checkIDCompany(String number, String u_name);
	public void updatePassCompany(String c_id,String c_pass);
	
	//ȸ�� ����
	public void updateUser(UserVO vo);
	public void updateUser2(UserVO vo);
	//��ü ȸ�� ����
	public void updateCompany(CompanyVO vo);
	public void updateCompany2(CompanyVO vo);
}
