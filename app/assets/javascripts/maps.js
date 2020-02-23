var userName = 'Ma position'


function initMap(latitude,longitude, targetedDiv, userName, setZoom) {

  map = new google.maps.Map(targetedDiv, {
  center: {lat: latitude, lng: longitude},
  zoom: setZoom
});


var userPosition = {lat: latitude, lng: longitude};

var marker = new google.maps.Marker({
  position: userPosition,
  map: map,
  title: userName
});


return map

};


function addMarkerInside(latitude, longitude, map, userName) {
  var blueDot = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
  var marker = new google.maps.Marker({
  position: {lat:latitude,lng:longitude},
  title: userName,
  map: map,
  icon:blueDot
  });
};

addMarkerOutside

function addMarkerOutside(latitude, longitude, map, userName) {
  var blueDot = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
  var marker = new google.maps.Marker({
  position: {lat:latitude,lng:longitude},
  title: userName,
  map: map,
  icon:blueDot
  });
};
