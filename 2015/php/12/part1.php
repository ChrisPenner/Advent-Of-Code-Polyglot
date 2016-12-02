<?php

$input = file_get_contents("input");

$data = json_decode($input, true);

$sum = 0;
$array = new RecursiveIteratorIterator(new RecursiveArrayIterator($data));
foreach($array as $key => $value) {
    if(is_integer($value)) {
        $sum += $value;
    }
}

echo $sum;