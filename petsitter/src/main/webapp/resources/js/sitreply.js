/**
 * 
 */
console.log("Reply module......");

// var replyService ={};
// 함수형 변수. 현재 이름이 없는 함수를 가지고 있음.
const replyService = (function() {// 자바스크립트는 함수를 변수에 할당 가능.
   function add(form ,callback, error) {
      // reply : 덧글 객체,
      // callback : 덧글 등록후 수행할 메소드. 비동기.
      // 주문과 동시에 처리할 내용도 전달. 페이지 이동없이 새로운 내용 갱신.
      console.log("add reply......");
      $.ajax({
         type: 'post',
         url: '/sitreplies/new',
         data: form,
         enctype: 'multipart/form-data',
       processData: false,   // 필수
       contentType: false,
         // 전달 받은 객체를 json 으로 변환.
         //contentType: "application/json; charset=utf-8",
         success: function(result) {
            if (callback) {
               callback(result); 
            }
         },
         error: function(er) {
            if (error) {
               error(er);
            }
         }
      });
   }// 덧글쓰기 끝.

      
   // 댓글 목록 가져오기.
   function getList(param, callback, error) {
      console.log("getList......");
      var sbno = param.sbno;
      var page = param.page || 1;// 2개 갑중 하나로 변수 초기화.
      // 페이지 번호가 있으면 페이지 번호 전달 없으면 1전달.
      $.getJSON("/sitreplies/pages/" + sbno + "/" + page,
            function(data) {
               if (callback) {
                  //callback(data);// ReplyPageDTO 객체 리턴.
                  callback(data.replyTotalCnt, data.list);
               }
            }).fail(function(xhr, status, err) {
         // xhr : xml http request 의 약자.
         // 현재는 사용되지 않고, 형식만 맞춰줌.
         // 매개변수의 이름은 변경 가능하지만, 순서별로 역할이 정해져 있음.
         if (error) {
            error(er);
         }
      });
   }// 덧글 목록 가져오기 끝.
   function displayDateTime(timeValue){

      var dateObj = new Date(timeValue);
      // 덧글이 등록된 시간을 변수에 할당..
      var str="";
      var yy=dateObj.getFullYear();
    var mm=dateObj.getMonth()+1;// 리턴값이 0~11
    var dd=dateObj.getDate();
    var hh=dateObj.getHours();
    var mi=dateObj.getMinutes();
     
      
      return [yy,'/', (mm>9?'':'0')+mm,'/',
            (dd>9?'':'0')+dd,' ',(hh>9?'':'0')+hh, ':'
            ,(mi>9?'':'0')+mi].join('');
   }
 function displayDate(dateValue){


      var dateObj = new Date(dateValue);
      // 덧글이 등록된 시간을 변수에 할당..
      var str="";
      
      var yy=dateObj.getFullYear();
    var mm=dateObj.getMonth()+1;// 리턴값이 0~11
    var dd=dateObj.getDate();

     
      
      return [yy,'/', (mm>9?'':'0')+mm,'/',
            (dd>9?'':'0')+dd].join('');
   }
  function displayTime(timeValue){


      var timeObj = new Date(timeValue);
      // 덧글이 등록된 시간을 변수에 할당..
      var str="";
      

    var hh=timeObj.getHours();
    var mi=timeObj.getMinutes();
     
      
      return [(hh>9?'':'0')+hh, ':'
            ,(mi>9?'':'0')+mi].join('');
   }
   
   function get(rsbno, callback, error) {
      $.get("/sitreplies/" + rsbno, function(result) {
         if (callback) {
            callback(result);
         }
      }).fail(function(xhr, status, er) {
         if (error) {
            error(er);
         }
      });
   }
   
   
   function update(form, rsbno, callback, error) {
      console.log("rsbno: " + rsbno);
      $.ajax({
         type : 'post',
         url : '/sitreplies/' + rsbno,
         data: form,
         enctype: 'multipart/form-data',
           processData: false,   // 필수
           contentType: false,
         success : function(result, status, xhr) {
            if (callback) {
               callback(result);
            }
         },
         error : function(xhr, status, er) {
            if (error) {
               error(er);
            }
         }
      });
   }   
   
   // 덧글 삭제
   function remove(rsbno, replyer, callback, error) {
      $.ajax({
         type : 'delete',
         url : '/sitreplies/' + rsbno,
         data:JSON.stringify({rsbno:rsbno,replyer:replyer}),
         contentType : "application/json; charset=utf-8",
         success : function(deleteResult, status, xhr) {
            if (callback) {
               callback(deleteResult);
            }
         },
         error : function(xhr, status, er) {
            if (error) {
               error(er);
            }
         }
      });
   }         
   
   return {
      add: add,
      getList: getList,
      displayTime : displayTime,
      displayDate : displayDate,
      displayDateTime : displayDateTime,
      get: get,
      update: update,
      remove: remove 
   };// 변수명.호출명 예) replyService.add
})(); // 즉시 실행 함수: 명시하는 것과 동시에 메모리에 등록.

