
function initMap(latitude,longitude, targetedDiv) {
  map = new google.maps.Map(targetedDiv, {
  center: {lat: latitude, lng: longitude},
  zoom: 14
});

};