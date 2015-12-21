<?php

$input = "hxbxwxba";

while(true) {
    $input = incrementPassword($input);
    if(checkPassword($input)) {
        echo $input . "\n";
    }
}

function checkPassword($password) {
    $found = false;
    $chars = str_split($password);
    foreach ($chars as $pos => $char) {
        if ($pos > count($chars) - 3) {
            break;
        }
        if (ord($char) + 1 === ord($chars[$pos + 1]) && ord($char) + 2 === ord($chars[$pos + 2])) {
            $found = true;
        }
    }

    if (!$found) {
        return false;
    }

    foreach ($chars as $char) {
        if ($char === 'i' || $char === 'o' || $char === 'l') {
            return false;
        }
    }

    $ignoredChars = array();

    foreach ($chars as $pos => $char) {
        if ($pos > count($chars) - 2) {
            break;
        }
        if ($char === $chars[$pos + 1] && !in_array($char, $ignoredChars)) {
            $ignoredChars[] = $char;
        }
    }

    if (count($ignoredChars) < 2) {
        return false;
    }

    return true;
}

function incrementPassword($password) {
    $chars = str_split($password);

    $chars[count($chars) - 1] = chr(ord($chars[count($chars) - 1]) + 1);

    for ($i = count($chars) - 1; $i >= 0; $i--) {
        if (ord($chars[$i]) > ord('z')) {
            $chars[$i] = chr(ord($chars[$i]) - 26);
            $chars[$i - 1] = chr(ord($chars[$i - 1]) + 1);
        }
    }

    return implode("", $chars);
}