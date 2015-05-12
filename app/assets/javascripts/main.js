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
  $('#calendar').fullCalendar({
    height: 600,
    events: "/events/get_events",
    timezone: 'local'
  })
})


//radio boxes label plugin
$(document).ready(function(){
    $(":radio").labelauty(({ label: false }));
});


//makes flash messages disappear after 5 seconds
$(document).ready(function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 5000);
 })