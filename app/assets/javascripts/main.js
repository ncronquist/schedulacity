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
  // console.log('page loaded');
  $('#calendar').fullCalendar({
    // console.log('fullCalendar functions'),
    height: 600,
    events: "/events/get_events"
  })
  // console.log('after function')
})

