document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('event-image')){
    const ImageChoice = document.getElementById('image-choice');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      imageElement.setAttribute('class','pre-img');
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
      ImageChoice.appendChild(imageElement);
    };

    document.getElementById('event-image').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  }
});