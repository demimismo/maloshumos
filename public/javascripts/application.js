var maloshumos = {
  map: undefined,

  initialize: function() {
    var myOptions = {
      zoom: 12,
      center: new google.maps.LatLng(40.41831, -3.70275),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: true,
      mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
          position: google.maps.ControlPosition.BOTTOM_CENTER
      },
      panControl: false,
      zoomControl: true,
      zoomControlOptions: {
          style: google.maps.ZoomControlStyle.LARGE,
          position: google.maps.ControlPosition.LEFT_CENTER
      },
      scaleControl: false,
      streetViewControl: false
    }
    maloshumos.map = new google.maps.Map(document.getElementById("map"),
        myOptions);
    
    maloshumos.place_stations_on_map();
  },

  place_stations_on_map: function() {
    $('.inline_station').each(function() {
      var coords = $(this).text().match(/\((.*),\s(.*)\)/);
      var image = 'beachflag.png';
      var myLatLng = new google.maps.LatLng(coords[1], coords[2]);
      var beachMarker = new google.maps.Marker({
          position: myLatLng,
          map: maloshumos.map,
          icon: '/images/ico-sindatos.png'
      });

    });
    $('.inline_station').hide();
  },

  infowindow: function(options) {
    var marker = new mxn.Marker(new mxn.LatLonPoint(options.lat, options.lng));
    options.map.addMarkerWithData(marker,{
      infoBubble : ['<div class="gmbubble">',options.content,'</div>'].join(''),
      label : options.title,
      date : "new Date()",
      marker : 4,
      //iconShadow: "/images/ico-admisible.png",
      //iconShadowSize : [45,45],
      icon : ["/images/ico-", options.suffix, ".png"].join(''),
      iconSize : [45,45],
      draggable : false,
      hover : false
    });
    return marker;
  }
}
