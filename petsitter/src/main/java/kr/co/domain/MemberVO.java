package kr.co.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
   private String userid;
   private String userpw;
   private String userName;
   private String gender;
   private String phone;
   private String nick;
   private boolean enabled; // 계정 정지 유무
   private Date regDate;
   private Date updateDate;
   private List<AuthVO> authList;
   // 하나의 아이디는 여러개의 권한 소유 가능.
   private String email;
   private String zipCode;
   private String address;
   private String detailAddress;
   private String extraAddress;
   
   private int userPoint;
}