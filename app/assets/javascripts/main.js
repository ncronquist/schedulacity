// $(function(){

//   //navbar modal open (login and signup)
// $('#openSignup').click(function(){
//   $('#signupmodal').modal({show:true})
// });

// $('#openLogin').click(function(){
//   $('#loginmodal').modal({show:true})
// });

// });


//fullcalendar
$(function(){

  //user signup validation
  $('#new_user').validate({
    debug: true,
    rules: {
      "user[name]": {
        required: true,
        maxlength: 25
      },
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        required: true,
        minlength: 6
      },
      "user[password_confirmation]": {
        required: true,
        equalTo: "#user_password"
      }
    }
  });
  //fullCalendar method
  $('#calendar').fullCalendar({
    height: 600,
    events: "/events/get_events",
    timezone: 'local'
  })
  //dropdown for class#index page
  $('.class-state').on('change',function(){
    if($('.class-state').val() === 'closed') {
      $('.closed-classes').removeClass('hidden');
      $('.open-classes').addClass('hidden');
    }else{
      $('.closed-classes').addClass('hidden');
      $('.open-classes').removeClass('hidden');
    }
  })

})


//radio boxes label plugin
$(document).ready(function(){
    $(":radio").labelauty(({ label: false }));
    $(".to-labelauty").labelauty({ minimum_width: "100px" });
    $(".to-labelauty-icon").labelauty({ label: false });
});


//makes flash messages disappear after 5 seconds
$(document).ready(function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 5000);
 })
