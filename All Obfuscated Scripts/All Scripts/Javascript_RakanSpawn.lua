--[[
	id: tAHWrypkVk-CLkaFNsTtu
	name: Javascript_RakanSpawn
	description: JS
	time1: 2021-05-28 13:53:02.747032+00
	time2: 2021-05-28 13:53:02.747033+00
	uploader: 338
	uploadersession: M6JI_ewz98DfnVAErszqbtsD8vvcSc
	flag: f
--]]


$(document).ready(function(){


 window.addEventListener('message', function( event ) {
  var item = event.data;

if ( item.showPlayerMenu == true ) {
$('body').css('background-color','transparent');

$('.container-fluid').css('display','block');
} else if ( item.showPlayerMenu == false ) {

$('.container-fluid').css('display','none');
$('body').css('background-color','transparent important!');
$("body").css("background-image","none");

  } else if (item.OpenAdminMenu2 == true) {
    $('.container-admin').css('display','block');
  } else if (item.OpenAdminMenu2 == false) {
    $('.container-admin').css('display','none');
    $('body').css('background-color','transparent important!');
    $("body").css("background-image","none");
  }
});


    $("#LoginButton").click(function(){
      Swal.fire({
          title: 'هل انت متأكد؟',
          text: "بعد التأكيد ستسجل دخولك",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'حسناً',
          cancelButtonText: 'الغاء',
          reverseButtons: true
        }).then((result) => {
          if (result.isConfirmed) {
              Swal.fire(
              'حسناً',
              'ستقوم بإستلام اشعار يفيدك اذا تم الدخول ام لا (يعتمد على اوقات تسجيل الدخول)',
              'success'
            )
            $.post('http://Rakan_VIP/RakanLogin', JSON.stringify({}));2          
          } else if (
            result.dismiss === Swal.DismissReason.cancel
          ) {
              Swal.fire({
              title: 'تم الغاء تسجيل الدخول',
              text: "يمكنك محاولة تسجيل الدخول مرة اخرى !",
              icon: 'error',
              confirmButtonText: 'حسناً'
              })
              $.post('http://Rakan_VIP/RakanLoginFailed', JSON.stringify({}));2
          }
        })
  });


$("#AjaxTest").click(function(){
    Swal.fire({
      title: "ارسال رسالة",
      text: "ستتمكن هنا من ارسال رسالة الى جميع اللاعبين تفيدهم بانه تم افتتاح نقطة الرسباون",
      input: 'text',
      confirmButtonText: 'ارسال',
      cancelButtonText: 'الغاء',
      showCancelButton: true        
  }).then((result) => {
      if (result.value) {
        Swal.fire({
          title: "تم ارسال الرسالة بنجاح !",
          text: "تم ارسال رسالة الى جميع اللاعبين \n , نص الرسالة : \n " + result.value,
          icon: 'info',
          confirmButtonText: 'حسناً'
          })
          $.post('http://Rakan_VIP/RakanSendMessageAP', JSON.stringify({
            messagetop : result.value,
          }));2
      } else if (
        result.dismiss === Swal.DismissReason.cancel
      ) {
          Swal.fire({
          title: 'تم الغاء العملية بنجاح',
          icon: 'error',
          confirmButtonText: 'حسناً'
          })
      }
  });
});



    $("#OutButton").click(function(){       
        Swal.fire({
            title: 'هل انت متأكد؟',
            text: "بعد التأكيد ستسجل خروجك",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'حسناً',
            cancelButtonText: 'الغاء',
            reverseButtons: true
          }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire(
                'حسناً',
                'ستقوم بإستلام اشعار يفيدك اذا تم تسجيل الخروج ام لا (يعتمد اذا لم تكن مسجل دخولك ام لا)',
                'success'
              )
              $.post('http://Rakan_VIP/RakanLogout', JSON.stringify({}));2      
            } else if (
              result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire({
                title: 'تم الغاء تسجيل الدخول',
                text: "يمكنك محاولة تسجيل الدخول مرة اخرى !",
                icon: 'error',
                confirmButtonText: 'حسناً'
                })
                $.post('http://Rakan_VIP/RakanLogoutFailed', JSON.stringify({}));2
            }
          })
    });
    
    $("#closebtn").click(function(){
      $.post('http://Rakan_VIP/closeButton', JSON.stringify({}));2
  });

  $("#closebuttonadmin").click(function(){
    $.post('http://Rakan_VIP/closeButtonAdmin', JSON.stringify({}));2
});

  $("#OpenAdminPage").click(function(){
    Swal.fire({
      title: 'هل انت متأكد؟',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'نعم',
      cancelButtonText: 'الغاء',
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
      $("body").load( "./admin.html" );
        }
    })

});


$("#OpenWithMessage").click(function(){
  Swal.fire({
    title: "ارسال رسالة",
    text: "ستتمكن هنا من ارسال رسالة الى جميع اللاعبين تفيدهم بانه تم افتتاح نقطة الرسباون",
    input: 'text',
    confirmButtonText: 'ارسال',
    cancelButtonText: 'الغاء',
    showCancelButton: true        
}).then((result) => {
    if (result.value) {
      Swal.fire({
        title: "تم ارسال الرسالة بنجاح !",
        text: "تم ارسال رسالة الى جميع اللاعبين \n , نص الرسالة : \n " + result.value,
        icon: 'info',
        confirmButtonText: 'حسناً'
        })
        $.post('http://Rakan_VIP/RakanSendMessageAP', JSON.stringify({
          messagetop : result.value,
        }));2
    } else if (
      result.dismiss === Swal.DismissReason.cancel
    ) {
        Swal.fire({
        title: 'تم الغاء العملية بنجاح',
        icon: 'error',
        confirmButtonText: 'حسناً'
        })
    }
});
});

})