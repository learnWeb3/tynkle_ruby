var userName = 'Ma position'


function initMap(latitude,longitude, targetedDiv, userName) {

  map = new google.maps.Map(targetedDiv, {
  center: {lat: latitude, lng: longitude},
  zoom: 14
});


var userPosition = {lat: latitude, lng: longitude};

var marker = new google.maps.Marker({
  position: userPosition,
  map: map,
  title: userName
});


};