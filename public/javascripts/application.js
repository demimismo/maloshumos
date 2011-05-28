var maloshumos = {
  map: undefined,

  initialize: function() {
    $('#station_id').next().hide();
    $('#station_id').change(function() {
      if ($(this).val() != "") {
        jQuery(this).parent().submit();
      } 
    });

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
      var myLatLng = new google.maps.LatLng(coords[1], coords[2]);
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: maloshumos.map,
          icon: '/images/ico-sindatos.png'
      });
      var infowindow = new google.maps.InfoWindow({
        content: $(this).html()
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(maloshumos.map, marker);
      });
    });
    $('.inline_station').hide();  
  }

}
