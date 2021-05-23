$(function () {
  $prefecture_id = $('#prefecture-id');
  $prefecture_id.on('change', function () {
    const prefecture_id = $prefecture_id.val();
    $.ajax({
      type: 'GET',
      url: '/tweets/get_cities',
      data: { prefecture_id: prefecture_id },
      dataType: 'json'
    })
    .done(function (data) {
      $('#city-id option').remove();
      $('#city-id').append(
       `<option value>指定なし </option>`
      );
      $(data).each(function(i,city) {
        $('#city-id').append(
          `<option value=${city.id}>${city.city} </option>`
        );
      });
    });
  })
});

