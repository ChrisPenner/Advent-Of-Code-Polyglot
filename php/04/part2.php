<?php

$input = file_get_contents("input");

$i = 0;

while (substr(md5($input . $i), 0, 6) !== "000000") {
    $i++;
}

echo $i;