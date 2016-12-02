<?php

$input = array(
    array(2, 0, -2, 0, 3),
    array(0, 5, -3, 0, 3),
    array(0, 0, 5, -1, 8),
    array(0, -1, 0, 5, 8)
);

$maxScore = 0;

for ($a = 0; $a <= 100; $a++) {
    echo $a . "\n";
    for ($b = 0; $b <= 100 - $a; $b++) {
        for ($c = 0; $c <= 100 - $a - $b; $c++) {
            $d = 100 - $a - $b - $c;
            $eSum = $a * $input[0][4] + $b * $input[1][4] + $c * $input[2][4] + $d * $input[3][4];

            if ($eSum !== 500) {
                continue;
            }

            $aSum = $a * $input[0][0] + $b * $input[1][0] + $c * $input[2][0] + $d * $input[3][0];
            $bSum = $a * $input[0][1] + $b * $input[1][1] + $c * $input[2][1] + $d * $input[3][1];
            $cSum = $a * $input[0][2] + $b * $input[1][2] + $c * $input[2][2] + $d * $input[3][2];
            $dSum = $a * $input[0][3] + $b * $input[1][3] + $c * $input[2][3] + $d * $input[3][3];

            $aSum = max(0, $aSum);
            $bSum = max(0, $bSum);
            $cSum = max(0, $cSum);
            $dSum = max(0, $dSum);

            $score = $aSum * $bSum * $cSum * $dSum;

            if ($score > $maxScore) {
                $maxScore = $score;
            }
        }
    }
}

echo $maxScore;