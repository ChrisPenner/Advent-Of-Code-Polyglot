<?php

$input = file_get_contents("input");

$lines = explode("\n", $input);

$values = array();
foreach ($lines as $line) {
    $parts = explode("->", $line);
    $expression = trim($parts[0]);

    $words = explode(" ", $expression);
    foreach ($words as $key => $word) {
        if (!is_numeric($word) && strtolower($word) == $word) {
            $words[$key] = trim($words[$key]);
        }
    }
    $expression = implode(" ", $words);

    $values[trim($parts[1])] = trim($expression);
}

list($solution, $values) = getActualValue('a', $values);
echo $solution;


function getActualValue($label, $values) {
    $words = explode(" ", $values[$label]);

    for ($i = 0; isset($words[$i]); $i++) {
        if (strtolower($words[$i]) == $words[$i] && !is_numeric($words[$i])) {
            list($words[$i], $values) = getActualValue($words[$i], $values);
        }
    }

    $evaluated = evaluateValue(implode(" ", $words));
    $values[$label] = $evaluated;

    return array($evaluated, $values);
}

function evaluateValue($value) {
    $words = explode(" ", $value);
    if (!isset($words[1])) {
        return $value;
    }

    if ($words[0] === 'NOT' && is_numeric($words[1])) {
        return ~ intval($words[1]) + 65536;
    }

    if (!isset($words[2])) {
        return $value;
    }

    if ($words[1] === 'AND' && is_numeric($words[0]) && is_numeric($words[2])) {
        return intval($words[0]) & intval($words[2]);
    }

    if ($words[1] === 'OR' && is_numeric($words[0]) && is_numeric($words[2])) {
        return intval($words[0]) | intval($words[2]);
    }

    if ($words[1] === 'LSHIFT' && is_numeric($words[0]) && is_numeric($words[2])) {
        return intval($words[0]) << intval($words[2]);
    }

    if ($words[1] === 'RSHIFT' && is_numeric($words[0]) && is_numeric($words[2])) {
        return intval($words[0]) >> intval($words[2]);
    }

    return $value;
}