var maloshumos = {
  infowindow: function(options) {
    options.map.addMarkerWithData(new mxn.Marker(new mxn.LatLonPoint(options.lat, options.lng)),{
      infoBubble : options.content,
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
  }
}
