<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$happiness = array();
$persons = array();

foreach ($lines as $line) {
    $words = explode(" ", $line);
    $firstPerson = trim($words[0]);
    $secondPerson = trim(str_replace(".", "", $words[10]));

    $amount = intval($words[3]);

    if ($words[2] == 'lose') {
        $amount *= -1;
    }

    if (!isset($happiness[$firstPerson][$secondPerson])) {
        $happiness[$firstPerson][$secondPerson] = 0;
        $happiness[$secondPerson][$firstPerson] = 0;
    }

    $happiness[$firstPerson][$secondPerson] += $amount;
    $happiness[$secondPerson][$firstPerson] += $amount;

    if (!in_array($firstPerson, $persons)) {
        $persons[] = $firstPerson;
    }
}

$allOptions = getAllOptions($persons);

$maxHappiness = 0;

foreach ($allOptions as $option) {
    $happinessDifference = calculateHappiness($option, $happiness);
    if ($happinessDifference > $maxHappiness) {
        $maxHappiness = $happinessDifference;
    }
}

echo $maxHappiness;

function getAllOptions($people) {
    if (count($people) == 1) {
        return $people;
    }

    $allOptions = array();
    foreach ($people as $index => $person) {
        $newPeople = $people;
        unset($newPeople[$index]);

        $options = getAllOptions($newPeople);

        foreach ($options as $option) {
            $allOptions[] = $person . "," . $option;
        }
    }

    return $allOptions;
}

function calculateHappiness($option, $happiness) {
    $words = explode(",", $option);

    $totalHappiness = 0;
    for ($i = 0; $i < count($words) - 1; $i++) {
        $totalHappiness += $happiness[$words[$i]][$words[$i + 1]];
    }

    $totalHappiness += $happiness[$words[0]][$words[count($words) - 1]];

    return $totalHappiness;
}