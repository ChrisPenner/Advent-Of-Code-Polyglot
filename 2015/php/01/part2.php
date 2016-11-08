<?php

$input = file_get_contents("input");

for ($i = 0; $i < strlen($input); $i++) {
    $inputSubstring = substr($input, 0, $i);
    $result = substr_count($inputSubstring, "(") - substr_count($inputSubstring, ")");
    if ($result < 0) {
        echo $i;
        die();
    }
}
