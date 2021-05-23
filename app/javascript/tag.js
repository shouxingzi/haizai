$(function () {
  $('#tweet_name').on('keyup', function () {
    var keyword = $('#tweet_name').val();
    const comma = keyword.lastIndexOf(',');
    keyword = keyword.substring(comma + 1);
    $.ajax({
      type: 'GET',
      url: '/tweets/ajax_tag_search',
      data: { keyword: keyword },
      dataType: 'json'
    })
    .done(function (data) { 
      $searchResult = $('#search-result');
      $searchResult.html("");
      if (data) {
        keyword = data.keyword;
        keyword.forEach((tag) => {      
         $childElement = $("<div>",{
           "class" : "child",
           "id" : "tag.id",
           "html" : tag.name
          });
          $searchResult.append($childElement);
          $clickElement = $('#tag.id');
          $clickElement.on('click', function() {  
            $('#tweet_name').value = $clickElement.textContent;
            $clickElement.remove();
          });
        });
      }
    });
  });
});






