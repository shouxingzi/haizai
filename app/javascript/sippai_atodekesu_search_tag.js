$(function () {
  if ($('#search-tag-name')) {
    $('#search-tag-name').on('keyup', function () {
      let search_keyword = $('#search-tag-name').val();
      const big_space = search_keyword.lastIndexOf('　');
      search_keyword = search_keyword.substring(big_space + 1);
      const small_space = search_keyword.lastIndexOf(' ');
      const keyword = search_keyword.substring(small_space + 1);
      tag_ajax(keyword)
    });
  } else if ($('#form-tag-name')) {
    $('#form-tag-name').on('keyup', function () {
    let form_keyword = $('#form-tag-name').val();
    const comma = form_keyword.lastIndexOf(',');
    const keyword = form_keyword.substring(comma + 1);
    tag_ajax(keyword)
    });
  }      

  function tag_ajax (keyword) {
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
            $("[id*='tag-name']").value = $clickElement.textContent;
            $clickElement.remove();
          });
        });
      }
    });
  }
});