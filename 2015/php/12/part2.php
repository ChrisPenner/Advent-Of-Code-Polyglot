<?php

$input = file_get_contents("input");

$data = json_decode($input);

$data = filterData($data);

echo getSum($data);

function filterData($data) {
    foreach ($data as $index => $item) {
        if ($item == 'red' && is_object($data)) {
            return array();
        }
        if (is_object($item) || is_array($item)) {
            if(is_object($data)) {
                $data->$index = filterData($item);
            } elseif(is_array($data)) {
                $data[$index] = filterData($item);
            }
        }
    }

    return $data;
}

function getSum($data) {
    if (!is_array($data) && !is_object($data)) {
        echo $data . ' => '. intval($data) . "\n";
        return intval($data);
    }

    $sum = 0;

    foreach ($data as $index => $item) {
        if (is_array($item)) {
            $sum += getSum($item);
        } elseif (is_object($item)) {
            if (in_array('red', get_object_vars($item), true) === false) {
                $sum += getSum($item);
            }
        } else {
            $sum += getSum($item);
        }
    }

    return $sum;
}