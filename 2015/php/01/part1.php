<?php

$input = file_get_contents("input");

$result = substr_count($input, "(") - substr_count($input, ")");

echo $result;