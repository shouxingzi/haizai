$(function () {
  if ($('#form-tag-name')) {
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
      $searchResult = $('#tag-search-result');
      $searchResult.html("");
      if (data) {
        $selectElement = $("<select>",{
            "class" : "tag-list",
            "id" : "tag-list",
        });
        $searchResult.append($selectElement);
        $('#tag-list').width('98%');
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






