<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$distances = array();
$foundPlaces = array();

foreach ($lines as $line) {
    $words = explode(" ", $line);
    $distances[$words[0]][$words[2]] = $words[4];
    $distances[$words[2]][$words[0]] = $words[4];
    if (!in_array($words[0], $foundPlaces)) {
        $foundPlaces[] = $words[0];
    }
    if (!in_array($words[2], $foundPlaces)) {
        $foundPlaces[] = $words[2];
    }
}

$allRoutes = getAllRoutes($foundPlaces);
$maxDistance = 0;
foreach ($allRoutes as $route) {
    $distance = calculateRouteDistance($route, $distances);

    if($distance > $maxDistance) {
        $maxDistance = $distance;
    }
}

echo $maxDistance;

function getAllRoutes($places) {
    if (count($places) == 1) {
        return $places;
    }
    $allRoutes = array();
    foreach ($places as $index => $place) {
        $newPlaces = $places;
        unset($newPlaces[$index]);

        $routes = getAllRoutes($newPlaces);

        foreach ($routes as $route) {
            $allRoutes[] = $place . "," . $route;
        }
    }
    return $allRoutes;
}

function calculateRouteDistance($route, $distance) {
    $words = explode(",", $route);

    $totalLength = 0;
    for ($i = 0; $i < count($words) - 1; $i++) {
        $totalLength += $distance[$words[$i]][$words[$i + 1]];
    }

    return $totalLength;
}