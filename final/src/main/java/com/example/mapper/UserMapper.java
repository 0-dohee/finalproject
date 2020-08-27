package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.domain.BlackVO;
import com.example.domain.CompanyOptionVO;
import com.example.domain.CompanyVO;
import com.example.domain.UserTagVO;
import com.example.domain.UserVO;

public interface UserMapper {
	//회원가입
	public void insert(UserVO vo);
	public void insertUsertag(String t_id, String t_k_id,String t_tag);
	public void insertKakao(UserVO vo);
	//업체 회원가입
	public void insertCompany(CompanyVO vo);
	public void insertCompanyoption(String c_o_id,String c_o_option);
	//회원 삭제
	public void usercancel(@Param("u_id") String u_id, @Param("u_k_id") String u_k_id);
	public void delete(String u_id);
	public void deleteTag(@Param("t_id") String u_id, @Param("t_k_id") String u_k_id);
	public void deletehotplacelike(String u_id);
	//업체 삭제
	public void deleteCompany(String c_id);
	public void deleteOption(String c_id);
	//회원 읽어오기
	public UserVO loginread(String u_id);
	public UserVO read(@Param("u_id") String u_id, @Param("u_k_id") String u_k_id);
	public UserVO kakaoread(String u_id, String u_k_id);
	public List<UserTagVO> readtag(String t_id);
	public String readid(String u_id,String u_k_id);
	public String readkakao(String u_k_id,String u_id);
	//업체 읽어오기
	public CompanyVO readCompany(String c_id);
	public List<CompanyOptionVO> readOption(String c_id);
	public String readcompanyid(String c_id);
	public String readcompanyNumber(String c_id);
	//회원가입 이메일 인증
	public int GetKey(String u_id, String u_key);
	public int alter_userKey(String u_id,String key);
	//업체 회원가입 이메일 인증
	public int GetKeyCompany(String c_id, String c_key);
	public int alter_KeyCompany(String c_id,String key);
	//ID/PW 찾기
	public int checkName(String u_birthday, String u_name);
	public List<UserVO> checkID(String u_birthday, String u_name);
	public void updatePass(String u_id,String u_pass);
	//업체 ID/PW 찾기
	public int checkNameCompany(String number, String name);
	public String checkIDCompany(String number, String u_name);
	public void updatePassCompany(String c_id,String c_pass);
	
	//회원 수정
	public void updateUser(UserVO vo);
	public void updateUser2(UserVO vo);
	public void updateKakao(UserVO vo);
	//업체 회원 수정
	public void updateCompany(CompanyVO vo);
	public void updateCompany2(CompanyVO vo);
	
	//신고하기
	public void insertblack(BlackVO vo);
	public int count(String u_id,String u_k_id);
	
	public List<HashMap<String,Object>>userroombooking(@Param("u_id")String u_id,@Param("u_k_id") String u_k_id);
}
