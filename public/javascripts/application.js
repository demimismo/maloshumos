var maloshumos = {
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
