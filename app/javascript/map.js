
document.addEventListener('DOMContentLoaded', () => {
  const modalMap = document.getElementById('modal-map')
  if (modalMap != null) {
    const modalScreen = document.getElementsByClassName('modal_screen');
    const closeIconModal = document.getElementsByClassName('close_icon_modal');
    modalMap.addEventListener('click', function(e){
      modalScreen[0].classList.remove('hidden');
      initMap();
    });
    closeIconModal[0].addEventListener('click', function(e){
      modalScreen[0].classList.add('hidden');
    });
  }
});

function initMap() {
  const showMap = document.getElementById('show-map');
  const inputAddress = document.getElementById('address').textContent;
  const geocoder = new google.maps.Geocoder();

  geocoder.geocode({ address: inputAddress }, function(results, status){
    if (status === 'OK' && results[0]){
      const map = new google.maps.Map(showMap, {
        center: results[0].geometry.location,
        zoom: 16
      });
      const marker = new google.maps.Marker({
        position: results[0].geometry.location,
        map: map,
      });
      const latlng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
      const content = '<div id="map_content"><p>' + inputAddress;
      var infowindow = new google.maps.InfoWindow({
        content: content,
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
      });
    } else {
        alert('該当する結果がありませんでした:' + status);
        return;
    }
  });
}