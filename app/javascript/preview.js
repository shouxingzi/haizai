$(function () {
  if ( $('#image') ){
    $imageList = $('#image-list');
    const createImageHTML = (blob) => {
      $imageElement = $("<div>");
      $blobImage = $("<image>");
      $blobImage.attr("src", blob);
      $imageElement.append($blobImage);
      $imageList.append($imageElement);
    };

    $image = $('#image');
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