document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('event-image')){
    const ImageChoice = document.getElementById('image-choice')
    document.getElementById('event-image').addEventListener('change', function(e){
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
      ImageChoice.appendChild(imageElement)
    });
  }
});