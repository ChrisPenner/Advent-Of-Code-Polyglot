<?php

$input = file_get_contents('input');

$totalCapacity = 150;

$values = explode("\n", $input);



foreach ($values as $key => $value) {
    $values[$key] = intval(trim($value));
}

$options =  getAllCombinations($values, $totalCapacity);

$minContainers = 100;

foreach ($options as $option) {
    $containers = count(explode(",", $option));
    if ($containers < $minContainers) {
        $minContainers = $containers;
    }
}

$amountWithMinContainers = 0;

foreach ($options as $option) {
    if (count(explode(",", $option)) == $minContainers) {
        $amountWithMinContainers++;
    }
}

echo $amountWithMinContainers;

function getAllCombinations($numbers, $targetValue) {
    if (count($numbers) == 1) {
        if (reset($numbers) == $targetValue) {
            return array(reset($numbers));
        } else {
            return array();
        }
    }

    $options = array();
    foreach ($numbers as $key => $number) {
        $newNumbers = $numbers;
        for ($i = 0; $i <= $key; $i++) {
            unset($newNumbers[$i]);
        }

        if ($targetValue - $number == 0) {
            $options[] = $number;
        }

        if ($targetValue - $number > 0) {
            $subOptions = getAllCombinations($newNumbers, $targetValue - $number);
            foreach ($subOptions as $subOption) {
                $options[] = $number . ',' . $subOption;
            }
        }
    }

    return $options;
}