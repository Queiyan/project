package kr.co.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class SitRequestReplyVO {
   private Long rsbno;
   private Long sbno;
   private String reply;
   private String replyer;
   private String address;
   private String detailAddress;
   private String extraAddress;
   private String petType;
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
   @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
   private Date startDateTime;
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
   @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
   private Date endDateTime;
   @JsonFormat(pattern = "yyyy-MM-dd")
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private Date startDate;
   @JsonFormat(pattern = "yyyy-MM-dd")
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private Date endDate;
   @JsonFormat(pattern = "HH:mm")
   @DateTimeFormat(pattern = "HH:mm")
   private Date startTime;
   @JsonFormat(pattern = "HH:mm")
   @DateTimeFormat(pattern = "HH:mm")
   private Date endTime;
   private Date replyDate;
   private Date updateDate;
   private String thumbImg;
   private String img;
   
   String sitter;
   
   int payment;
}