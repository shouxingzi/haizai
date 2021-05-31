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
        $selectElement = $("<select>",{
            "class" : "tag-list",
            "id" : "tag-list",
        });
        $searchResult.append($selectElement);
        keyword = data.keyword;
        keyword.forEach((tag) => { 
          $optionElement = $("<option>",{
            "class" : "option-tag",
            "id" : "option-tag",
            "text" : tag.name
          });
          $('#tag-list').append($optionElement);
          $clickElement = $('#option-tag')
          $clickElement.on('click', function() {
            $("[id*='tag-name']").val = $clickElement.val
            $clickElement.remove();
          });    
        });
      }
    }); 
  }
});
