$(function () {
  if ( $('#tweet_image') ){
    $ImageList = $('#image-list');
    const createImageHTML = (blob) => {
      $imageElement = $("<div>");
      $blobImage = $("<img>");
      $blobImage.attr({
        src: blob,
        width: 300,
        height: 200
      });
      $imageElement.append($blobImage);
      $ImageList.append($imageElement);
    };

    $image = $('#tweet_image');
    $image.on('change', function (e) {
      $imageContent = $('img');
      if ($imageContent) {
        $imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  }
});

