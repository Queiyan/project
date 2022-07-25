/**
 * 
 */
console.log("sitter module......");

var sitterService = (function() {// 자바스크립트는 함수를 변수에 할당 가능.
   function add(sitterInfo, rbno,callback, error) {
      // reply : 덧글 객체,
      // callback : 덧글 등록후 수행할 메소드. 비동기.
      // 주문과 동시에 처리할 내용도 전달. 페이지 이동없이 새로운 내용 갱신.
      console.log("add sitterInfo......");
      $.ajax({
         type: 'post',
         url: '/sitterInfo/new',
         data: JSON.stringify(sitterInfo),
         // 전달 받은 객체를 json 으로 변환.
         contentType: "application/json; charset=utf-8",
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
      
   // 리뷰 글과 별점 목록 가져오기.(돌봄 매니저에 대한)
   
   function getList(sitter, callback, error) {
      console.log("getList......");
      $.get("/sitterInfo/list/" + sitter,
            function(data) {
               if (callback) {
                  callback(data)
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
  
   
   
   // 1.Id를 이용하여  별점과 돌봄횟수 Ajax를 사용하여 가져온다.
   // 2.js에 위치한 sitterService를 스크립트가 사용하며 sitterVal과 starRating 넣어주고 별점의 평균값을 리턴.
   
   function get(sitter, callback, error) {
      $.get("/sitterInfo/" + sitter, function(result) {
         if (callback) {
            callback(result);
         }
      }).fail(function(xhr, status, er) {
         if (error) {
            error(er);
         }
      });
   }
   
   
   
  
   
   return {
      add: add,
      getList: getList,
      get: get
   };// 변수명.호출명 예) replyService.add
})(); // 즉시 실행 함수: 명시하는 것과 동시에 메모리에 등록.

