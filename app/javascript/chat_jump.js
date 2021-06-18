$(function(){
  const href = $('#jump-trigger').attr("href");
  const target = $(href == "#" || href == "" ? 'html' : href);
  const position = target.offset().top;
  const speed = 0;
  $('#chats').animate({scrollTop:position}, speed, 'swing');
  return false;
});

