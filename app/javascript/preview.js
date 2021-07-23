

document.addEventListener('turbolinks:load', () => {
  if (document.URL.match( '/new' ) || document.URL.match( '/edit')) {
    document.getElementById('new_post').addEventListener('change', function(e){
      const file = e.target.files[0]
      const blob = window.URL.createObjectURL(file);
      
      const imageContent = document.getElementById('image_preview');
      if (imageContent){
        imageContent.setAttribute('src', blob);
      }
      else{
        const ImagePreview = document.getElementById('preview_area');
        const blobImage = document.createElement('img');
        blobImage.setAttribute('id', 'image_preview');
        blobImage.setAttribute('class', 'image_preview');
        blobImage.setAttribute('src', blob);
        ImagePreview.appendChild(blobImage);
      }
    });
  }
});