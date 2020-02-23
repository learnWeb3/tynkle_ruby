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


return map

};


function addMarker(latitude, longitude, map, userName) {
  var blueDot = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
  var marker = new google.maps.Marker({
  position: {lat:latitude,lng:longitude},
  title: userName,
  map: map,
  icon:blueDot
  });
};
