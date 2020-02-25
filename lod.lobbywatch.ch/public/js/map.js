/* global jsonld, L, wellknown */

function embeddedGraph (elementId) {
  var element = document.getElementById(elementId)

  if (!element) {
    return Promise.resolve({})
  }

  var json = JSON.parse(element.innerHTML)

  return jsonld.promises.flatten(json, {}).then(function (flat) {
    return jsonld.promises.expand(flat).then(function (json) {
      // if data contains quads, use the first graph
      if (json.length && '@graph' in json[0]) {
        json = json[0]['@graph']
      }

      return json
    })
  })
}

embeddedGraph('data').then(function (data) {
  var features = []

  data.forEach(function (subjectData) {
    Object.keys(subjectData).forEach(function (predicateIri) {
      if (predicateIri === '@id' || predicateIri === '@type') {
        return
      }

      var predicateValues = subjectData[predicateIri]

      predicateValues.forEach(function (predicateValue) {
        if (typeof predicateValue === 'object' && predicateValue['@type'] === 'http://www.opengis.net/ont/geosparql#wktLiteral') {
          features.push(wellknown.parse(predicateValue['@value']))
        }
      })
    })
  })

  if (features.length > 0) {
    var mapElement = document.createElement('div')

    mapElement.setAttribute('id', 'map')
    mapElement.setAttribute('style', 'height: 400px;')

    document.getElementById('media').appendChild(mapElement)

    var map = L.map('map').setView([47.5596, 7.5886], 12)

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      minZoom: 6,
      maxZoom: 12,
      attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors'
    }).addTo(map)

    features.forEach(function (feature) {
      L.geoJSON(feature).addTo(map)
    })
  }
})
