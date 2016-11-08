<?php

$input = "1113222113";

for ($i = 0; $i < 40; $i++) {
    $input = mutateString($input);
}
echo strlen($input);

function mutateString($string) {
    $newString = '';

    $chars = str_split($string);

    $sameString = '';

    $sameStrings = array();

    foreach ($chars as $index => $number) {
        $sameString .= $number;
        if (!isset($chars[$index + 1]) || $chars[$index + 1] != $number) {
            $sameStrings[] = $sameString;
            $sameString = '';
        }
    }

    foreach ($sameStrings as $sameString) {
        $newString .= strlen($sameString) . substr($sameString, 0, 1);
    }

    return $newString;
}