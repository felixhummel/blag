Troubleshooting
===============

Non-assignable model expression
-------------------------------
DOM element misses attribute.

First encounter::

    // html
    <leaflet center="dafuq"></leaflet>
    // js
    $scope.dafuq = { lat: '47.75443', lng: '11.99677', zoom: 4 };
    $scope.zoom = 4;

Solution::

    // html
    <leaflet center="dafuq" zoom="zoom"></leaflet>
    // js
    $scope.dafuq = { lat: '47.75443', lng: '11.99677', zoom: 4 };
    $scope.zoom = 4;

