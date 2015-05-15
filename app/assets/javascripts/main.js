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
    // debug: true,
    rules: {
      "new_user[name]": {
        required: true,
        maxlength: 25
      },
      "new_user[email]": {
        required: true,
        email: true
      },
      "new_user[password]": {
        required: true,
        minlength: 6
      },
      "new_user[password_confirmation]": {
        required: true,
        equalTo: "#new_user_password"
      }
    }
  });

  //new student validation
  $('#new_student').validate({
    // debug: true,
    rules: {
      "student[name]": {
        required: true,
      },
      "student[email]": {
        required: true,
        email: true
      },
      "student[dob]": {
        date: true
      },
      "student[phone_number]": {
        digits: true
      },
      "student[zip]": {
        digits: true
      }
    }
  });
  //new classgroup validation
  $('#new_classgroup').validate({
    rules: {
      "classgroup[name]": {
        required: true
      }
    }
  });
  //twilio text form
  $('#text-form').validate({
    rules: {
      "twilio[Hey]": {
        required: true
      }
    }
  })
  //fullCalendar method
  $('#calendar').fullCalendar({
    header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
    },
    defaultView: $(window).width() < 514 ? 'agendaDay' : 'month',
    height: 800,
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
  //google button resize
  function googleBtn(){
    if($(window).width() < 415) {
      $('.btn-google').text('Google Calendar');
    }
  }

  googleBtn();
})


//radio boxes label plugin
$(document).ready(function(){
    $(":radio").labelauty(({ label: false }));
    $(".to-labelauty").labelauty({ minimum_width: "100px" });
    $(".to-labelauty-xs").labelauty({ minimum_width: "60px", maximum_height: "50px", padding_left: "25px" });
    $(".to-labelauty-icon").labelauty({ label: false });
});


//makes flash messages disappear after 5 seconds
$(document).ready(function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 5000);
 })


  $(function () {
    $('.footable').footable();
  });


