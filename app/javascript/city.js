if (location.pathname.match("tweets/new")){
  $(function () {
    $('#tweet_prefecture_id').on('change', function () {
      const prefecture_id = $('#tweet_prefecture_id').val();
      console.log (prefecture_id);
      $.ajax({
        type: 'GET',
        url: '/tweets/get_cities',
        data: { prefecture_id: prefecture_id },
        dataType: 'json'
      })
      .done(function (data) {
        console.log(data);
        $('#tweet_city_id option').remove();
        $(data).each(function(i,city) {
            $('#tweet_city_id').append(
              `<option value=${city.id}>${city.city} </option>`
            );
        });
      })
    });
  });
};

