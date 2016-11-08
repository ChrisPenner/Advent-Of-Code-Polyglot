<?php

$input = file_get_contents("input");

$positions = array("0x0" => true);

$x = 0;
$y = 0;

foreach (str_split($input) as $index => $char) {
    if ($index % 2 !== 0) {
        continue;
    }
    switch ($char) {
        case '<':
            $x--;
            break;
        case '>':
            $x++;
            break;
        case 'v':
            $y--;
            break;
        case '^':
            $y++;
            break;
    }
    $positions[$x . 'x' . $y] = true;
}

$x = 0;
$y = 0;

foreach (str_split($input) as $index => $char) {
    if ($index % 2 !== 1) {
        continue;
    }
    switch ($char) {
        case '<':
            $x--;
            break;
        case '>':
            $x++;
            break;
        case 'v':
            $y--;
            break;
        case '^':
            $y++;
            break;
    }
    $positions[$x . 'x' . $y] = true;
}


echo count($positions);