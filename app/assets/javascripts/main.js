// $(function(){

//   //navbar modal open (login and signup)
// $('#openSignup').click(function(){
//   $('#signupmodal').modal({show:true})
// });

// $('#openLogin').click(function(){
//   $('#loginmodal').modal({show:true})
// });

// });

$(function(){
  $('#calendar').fullCalendar({
    height: 600,
    events: "/events/get_events",
    timezone: 'local'
  })
})

