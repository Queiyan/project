 
function check_passwd(mbrPwd) {
    var check1 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,20}$/
          .test(mbrPwd);
    if (!check1) {
       return "비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를\n조합하여 5~20자로 구성하세요.";
    }

    if (/(\w)\1\1/.test(mbrPwd)) {
       return '같은 문자를 3번 이상 사용하실 수 없습니다.';
    }

    var cnt = 0;
    var cnt2 = 0;
    var tmp = "";
    var tmp2 = "";
    var tmp3 = "";
    for (var i = 0; i < mbrPwd.length; i++) {
       tmp = mbrPwd.charAt(i);
       tmp2 = mbrPwd.charAt(i + 1);
       tmp3 = mbrPwd.charAt(i + 2);

       if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == 1
             && tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == 1) {
          cnt = cnt + 1;
       }
       if (tmp.charCodeAt(0) - tmp2.charCodeAt(0) == -1
             && tmp2.charCodeAt(0) - tmp3.charCodeAt(0) == -1) {
          cnt2 = cnt2 + 1;
       }
    }
    if (cnt > 0 || cnt2 > 0) {
       return '연속된 문자를 3번 이상 사용하실 수 없습니다.';
    }

    return '';
 }

 /*
 최소 8 자, 최소 하나의 문자 및 하나의 숫자 :
 "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
 
 최소 8 자, 최소 하나의 문자, 하나의 숫자 및 하나의 특수 문자 :
 "^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$"

 최소 8 자, 대문자 하나 이상, 소문자 하나 및 숫자 하나 :
 "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"

 최소 8 자, 대문자 하나 이상, 소문자 하나, 숫자 하나 및 특수 문자 하나 이상 :
 "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}"
 최소 8 자 및 최대 10 자, 대문자 하나 이상, 소문자 하나, 숫자 하나 및 특수 문자 하나 이상 :
 "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,10}"
 이메일 형식 :
 /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/

  */
 function GetData()
 {
    $.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/member/dept", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName,
                  csrfTokenValue);
         },
         //data : "list", // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            $.each(res, function(i, item) {
               $('#dept').append($('<option>', {
                  value : item.code,
                  text : item.name
               }));
            });
         },
         error : function(XMLHttpRequest, textStatus,
               errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });

      $.ajax({
         type : "POST", // HTTP method type(GET, POST) 형식이다.
         url : "/member/job", // 컨트롤러에서 대기중인 URL 주소이다.
         beforeSend : function(xhr) {
            xhr.setRequestHeader(csrfHeaderName,
                  csrfTokenValue);
         },
         //data : "list", // Json 형식의 데이터이다.
         success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
            $.each(res, function(i, item) {
               $('#job').append($('<option>', {
                  value : item.code,
                  text : item.name
               }));
            });
         },
         error : function(XMLHttpRequest, textStatus,
               errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("통신 실패.")
         }
      });
 } 
 
 // 실시간으로 남은 시간 보여 주는 함수 
 /*
     dt :datetime ,
     id : control ID
     
 */
 var timer;
 function CountDownTimer(dt, id) {
     var end = new Date(dt);
     var _second = 1000;
     var _minute = _second * 60;
     var _hour = _minute * 60;
     var _day = _hour * 24;
    // var timer;
     function showRemaining() {
         var now = new Date();
         var distance = end - now;
         if (distance < 0) {
             clearInterval(timer);
             $("#timerYN").val("y");
             document.getElementById(id).innerHTML = '다시 인증을 하여 주세요.';
             return;
         }
         var days = Math.floor(distance / _day);
         var hours = Math.floor((distance % _day) / _hour);
         var minutes = Math.floor((distance % _hour) / _minute);
         var seconds = Math.floor((distance % _minute) / _second);
         document.getElementById(id).innerHTML = "";
         //document.getElementById(id).innerHTML += days + '날자 ';
         //document.getElementById(id).innerHTML += hours + '시간 ';
         document.getElementById(id).innerHTML += minutes + '분 ';
         document.getElementById(id).innerHTML += seconds + '초'+' 남음';
     }
     timer = setInterval(showRemaining, 1000);
 }
 
 function deleteData(key)
 {
    var params = {
             key : key
          }
     $
           .ajax({
              type : 'POST',
              url : '/certification/delete',
              data : params,
              beforeSend : function(
                    xhr) {
                 xhr
                       .setRequestHeader(
                             csrfHeaderName,
                             csrfTokenValue);
              },
              success : function(res) {
               clearInterval(timer); // 타이머 중지 
               $("#smalltimer").text("인증 성공");
               $("#auth").val("yes"); // 인증 여부 
              },
              error : function(
                    XMLHttpRequest,
                    textStatus,
                    errorThrown) {
                 $("#smalltimer").text("인증 실패");
                // alert("인증 실패")
              }
           });
 }
 
 /* sms 발송 .. 
 param : key 암호화 키 
 type은 이메일 컨트롤 참조
 */
 function PhoneSend()
 {
   // alert(key)
    //return ;
    var key = $("#hidretval").val();
    var params = {
             form : '01085232382'      ,
            content : key            ,
            to    : $("#phone").val()   , //-들어가면 안보내지므료 -은 빼준다
            text      : "회원님의 인증번호는["+key+"]입니다"       
         }
         //alert(params.text)

         $.ajax({
            type : "POST", // HTTP method type(GET, POST) 형식이다.
            url : "/admin/sms/sendone", // 컨트롤러에서 대기중인 URL 주소이다.
            beforeSend : function(xhr) {
               xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data : params, // Json 형식의 데이터이다.
            success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
               alert("핸드폰으로 발송 되었습니다.핸드폰을 확인하여 주세요");

            },
            error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
               alert("핸드폰 발송 실패")
            }
         }); 
 }
 
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ready(function() {
   GetData(); // 데이터 바인딩 
   
   $(document).on("click","#useridcheck",function(){
      
      if($("#userid").val()=="")
      {
         $("#smalluserid").text("아이디을 확인하여 주세요");
         $("#userid").focus();
         return
      }
      else
      {
         $("#smalluserid").empty();
      }
           var params = {
              userid : $("#userid").val()
           };

           $.ajax({
              type : "POST", // HTTP method type(GET, POST) 형식이다.
              url : "/member/existid", // 컨트롤러에서 대기중인 URL 주소이다.
              beforeSend : function(xhr) {
                 xhr.setRequestHeader(
                       csrfHeaderName,
                       csrfTokenValue);
              },
              data : params, // Json 형식의 데이터이다.
              success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
                 if (res !== "no"){ //yes 면 o
                    //alert("사용 가능한 아이디입니다");
                    $("#smalluserid").text("사용 가능한 아이디입니다")
                    $("#hidduseridcheck").attr("value", "yes");
                 }else {
                    //alert("사용 불가능한 아이디입니다");
                    $("#smalluserid").text("사용 불가능한 아이디입니다")
                 }
                 $("#hidduseridcheck").val(res);
              },
              error : function(XMLHttpRequest,
                    textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                 alert("통신 실패.")
              }
           });
   });
   $(document).on("click","#save",function(e){
      e.preventDefault();
       var c1 = check_passwd($("#userpw")
                 .val());
           var emailcheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
                 .test($("#email").val());
           
     // 유효성 겁사 
                          //alert($("#userid").val())
                           if($("#userid").val() =="")
                        {
                           $("#smalluserid").text("아이디을 확인하여 주세요");
                           return
                        }
                        else
                        {
                           $("#smalluserid").empty();
                        }
                                 if ($("#hidduseridcheck").val() == "no") {
                                  //  alert("아이디 중복확인을 해주세요");
                                     $("#smalluserid").text("아이디 중복확인을 해주세요")
                                     $("#userid").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smalluserid").empty(); 
                                 }
                                 if ($("#userpw").val() == "") {
                                    //alert("비밀번호를 입력하여 주세요");
                                    $("#smallpw").text("비밀번호를 입력하여 주세요")
                                    $("#userpw").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallpw").empty();
                                 }
                                 if (c1 != "") {
                                    //alert(c1);
                                    $("#smallpw").text(c1);
                                    $("#userpw").focus()
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallpw").empty();
                                 }
                                 if ($("#userpw").val() != $(
                                       "#userpwe").val()) {
                                    //alert("비밀번호가 일치하지 않습니다");
                                    $("#smallpw").text("비밀번호가 일치하지 않습니다");
                                    $("#smallpwe").text("비밀번호가 일치하지 않습니다");                                    
                                    $("#userpwe").focus();
                                    return;
                                 }
                                 else
                                {
                                    $("#smallpw").empty();
                                     $("#smallpwe").empty();
                                }
                                 if ($("#username").val() == "") {
                                    //alert("이름를 입력하여 주세요");
                                    $("#smallusername").text("이름를 입력하여 주세요");
                                    $("#username").focus();
                                    return;
                                 }
                                 else
                                {
                                    $("#smallusername").empty();
                                }
                                 if ($("#hp").val() == "") {
                                    //alert("HP 번호를 입력하여 주세요");
                                    $("#smallhp").text("HP 번호를 입력하여 주세요")
                                    $("#hp").focus();
                                    return;
                                 }
                                 else
                                {
                                    $("#smallhp").empty();
                                }
                                 if ($("#phone").val() == "") {
                                    $("#smallphone").text("핸드폰번호를 입력하여 주세요")
                                    $("#phone").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallphone").empty();
                                 }
                                 if ($("#birth").val() == "") {
                                    //alert("생년월일을 입력하여 주세요");
                                    $("#smallbirth").text("생년월일을 입력하여 주세요")
                                    $("#birth").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallbirth").empty();
                                 }
                                 if ($("#dept").val() == "") {
                                    //alert("부서를 입력하여 주세요");
                                    $("#smalldept").text("부서를 입력하여 주세요")
                                    $("#dept").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smalldept").empty();
                                 }
                                 if ($("#job").val() == "") {
                                    //alert("직책을 입력하여 주세요");
                                    $("#smalljob").text("직책을 입력하여 주세요");
                                    $("#job").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smalljob").empty();
                                 }
                                 if ($("#email").val() == "") {
                                    //alert("이메일을 입력하여 주세요");
                                    $("#smallem").text("이메일을 입력하여 주세요");
                                    $("#email").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallem").empty();
                                 }
                                 if (!emailcheck) {
                                    //alert("email 형식을 확인하여 주세요")
                                    $("#smallem").text("email 형식을 확인하여 주세요");
                                    $("#email").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallem").empty();
                                 }
                                 
                                 // 인증 추가 
                                  if ($("#auth").val() != "yes") {
                                    //alert("이메일을 입력하여 주세요");
                                    $("#smalltimer").text("인증 하여 주세요");
                                    return;
                                 }
                                 else
                                 {
                                    $("#smalltimer").empty();
                                 }
                                 if ($("#zip").val() == "") {
                                    //alert("우편번호를 입력하여 주세요");
                                    $("#smallzip").text("우편번호를 입력하여 주세요");
                                    $("#zip").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smallzip").empty();
                                 }
                                 if ($("#addr1").val() == "") {
                                     //alert("주소를 입력하여 주세요");
                                     $("#smalladdr1").text("주소를 입력하여 주세요");
                                     $("#addr1").focus();
                                     return;
                                  }
                                 else
                                 {
                                    $("#smalladdr1").empty();
                                 }
                                 if ($("#addr2").val() == "") {
                                    //alert("상세주소를 입력하여 주세요");
                                    $("#smalladdr2").text("상세주소를 입력하여 주세요")
                                    $("#addr2").focus();
                                    return;
                                 }
                                 else
                                 {
                                    $("#smalladdr2").empty(); 
                                 }   
     // 유효성 검사
              //ajax 
                 var params = {
                                         userid : $('#userid').val(),
                                         userpw : $('#userpw').val(),
                                         username : $('#username').val(),
                                         sex : $('#sex').val(),
                                         birth : $('#birth').val(),
                                         email : $('#email').val(),
                                         zip : $('#zip').val(),
                                         addr1 : $('#addr1').val(),
                                         addr2 : $('#addr2').val(),
                                         phone : $('#phone').val(),
                                         hp : $('#hp').val(),
                                         job : $('#job').val(),
                                         dept : $('#dept').val(),
                                         day : $('#day').val()
                                      }
                                 $
                                       .ajax({
                                          type : 'POST',
                                          url : '/memberjoin',
                                          data : params,
                                          beforeSend : function(
                                                xhr) {
                                             xhr
                                                   .setRequestHeader(
                                                         csrfHeaderName,
                                                         csrfTokenValue);
                                          },
                                          success : function(res) {
                                             alert("회원가입이 완료되었습니다")
                                             window.location.href = "/login" //로그인창으로
                                          },
                                          error : function(
                                                XMLHttpRequest,
                                                textStatus,
                                                errorThrown) {
                                             alert("회원가입에 실패하였습니다")
                                          }
                                       });
              //ajax 
   });// save
   
   // 이메일 인증 버튼 눌렸을때 3분 시간을 주고 이메일 발송
   $(document).on("click","#btnphone",function(){
      if($("#auth").val()=="yes")
      {
         $("#smalltimer").text("이미 인증된 상태입니다");
         $("#btnphone").attr("disabled", true); //설정
           $("#phone").attr("disabled", true); //설정
      }
      if ($("#phone").val() == "") {
           $("#smallphone").text("핸드폰번호를 입력하여 주세요")
           $("#phone").focus();
           return;
        }
        else
        {
           $("#smallphone").empty();
        }
      var now = new Date();
      var mm = Number(now.getMonth()+1);
      
      if(mm<10)
      {
         mm = '0'+mm;
      }
      //alert(mm)
      var dd = now.getDate();
      if(dd<10)
      {
         dd ='0'+dd;
      }
      var yy =now.getFullYear();
      var hh = now.getHours();
      
      var m = now.getMinutes(); // /분
      if(m>=57)
      {
         m = Number(m)-60+3;//기존 코드 60-Number(m)+3
         now.setHours(1);
      }
      else
      {
         m=m +3;
      }
      var sec= now.getSeconds();
      var date = mm +'/'+dd+'/'+yy+' ' +hh +':'+m+":"+sec
      var day = yy+"-"+mm+"-"+dd+" "+hh+":"+m+":"+sec
      //alert(date);
      //ajax 
       var params = {
                                         day : day
                                      }
                                 $
                                       .ajax({
                                          type : 'POST',
                                          url : '/certification/Create',
                                          data : params,
                                          beforeSend : function(
                                                xhr) {
                                             xhr
                                                   .setRequestHeader(
                                                         csrfHeaderName,
                                                         csrfTokenValue);
                                          },
                                          success : function(res) {
                                            // alert(res)
                                             $("#timerYN").val("n"); // 3분 초기화 
                                             
                                             $("#hidretval").val(res);
                                           // sms 전송
                                             PhoneSend();
                                             CountDownTimer(date, 'smalltimer')
                                          },
                                          error : function(
                                                XMLHttpRequest,
                                                textStatus,
                                                errorThrown) {
                                             alert("암호화 실패")
                                          }
                                       });
      //ajax 
      //CountDownTimer(date, 'smalltimer'); //
   })
   
   $(document).on("keyup","#timer",function(){
      //if($("#smalltimer").text("인증 성공");
      var key= $(this).val();
      var keyLength = $(this).val().length;
      if($("#auth").val()=="yes")
      {
         $("#smalltimer").text("인증 성공");
         $("#btnphone").attr("disabled", true); //설정
         $(this).attr("disabled", true); //설정
           $("#phone").attr("disabled", true); //설정
           return;
      }
      
      if($("#timerYN").val()== "y")
      {
            alert("3분 경과 하였습니다 다시 인증하여 주세요")
            $(this).val("");
            return;
      }
      //ajax 
      var now = new Date();
      var mm = Number(now.getMonth()+1);
      
      if(mm<10)
      {
         mm = '0'+mm;
      }
      //alert(mm)
      var dd = now.getDate();
      if(dd<10)
      {
         dd ='0'+dd;
      }
      var yy =now.getFullYear();
      var hh = now.getHours();
      
      var m = now.getMinutes(); // /분
//       if(m>=57)
//       {
//          m = 60-Number(m) +3;
//          now.setHours(1); 
//       }
//       else
//       {
//          m=m +3;
//       }
      var sec= now.getSeconds();
      var date = mm +'/'+dd+'/'+yy+' ' +hh +':'+m+":"+sec
      var day = yy+"-"+mm+"-"+dd+" "+hh+":"+m+":"+sec
      //alert(date);
      //ajax 
       var params = {
                                         day : day ,
                                         key : key
                                      }
      if(keyLength>7) {
                                 $
                                       .ajax({
                                          type : 'POST',
                                          url : '/certification/get',
                                          data : params,
                                          beforeSend : function(
                                                xhr) {
                                             xhr
                                                   .setRequestHeader(
                                                         csrfHeaderName,
                                                         csrfTokenValue);
                                          },
                                          success : function(res) {
                                           clearInterval(timer); // 타이머 중지 
                                           $("#smalltimer").text("인증 성공");
                                           //
                                           $("#btnphone").attr("disabled", true); //설정
                                           $("#phone").attr("disabled", true); //설정
                                           $("#timmer").attr("disabled", true); //설정
                                           deleteData($("#hidretval").val()) // 삭제
                                           $("#auth").val("yes"); // 인증 여부 
                                          },
                                          error : function(
                                                XMLHttpRequest,
                                                textStatus,
                                                errorThrown) {
                                             $("#smalltimer").text("인증 실패");
                                            // alert("인증 실패")
                                          }
                                       });
      }
      //ajax 
   })
   
     $("#findzip")
                        .on(
                              "click",
                              function() {
                                 new daum.Postcode(
                                       {
                                          oncomplete : function(
                                                data) {
                                             var addr = ''; // 주소 변수
                                             var extraAddr = ''; // 참고항목 변수

                                             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                                                addr = data.roadAddress;
                                             } else { // 사용자가 지번 주소를 선택했을 경우(J)
                                                addr = data.jibunAddress;
                                             }

                                             document
                                                   .getElementById('zip').value = data.zonecode;
                                             document
                                                   .getElementById("addr1").value = addr;
                                             document
                                                   .getElementById(
                                                         "addr2")
                                                   .focus();
                                          }
                                       }).open();
             
                              });//end_click
     // 숫자만 입력가능                         
    $(document).on("keyup","#phone",function(){
       //alert("")
       $(this).val($(this).val().replace(/[^0-9]/g,""));    
    })
     $(document).on("keyup","#hp",function(){
       //alert("")
       $(this).val($(this).val().replace(/[^0-9]/g,""));    
    })
        
});  
 
