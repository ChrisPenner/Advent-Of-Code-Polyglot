<?php

$input = file_get_contents("input");

$positions = array("0x0" => true);

$x = 0;
$y = 0;

foreach (str_split($input) as $char) {
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
