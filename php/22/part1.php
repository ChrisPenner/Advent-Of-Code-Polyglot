<?php

$state = array('boss' => 58,'d' => 9,'hp' => 50,'m' => 500,'a' => 0,'shield' => 0,'poison' => 0,'recharge' => 0,'manaspent' => 0,'move' => 'player');
$spells = array('missile' => array(53,4,0),'drain' => array(73,2,2),'shield' => array(113,6),'poison' => array(173,6),'recharge' => array(229,5));

$min = PHP_INT_MAX;
$moves = array($state);

while ($state = array_shift($moves)) {
    $state['a'] = ($state['shield']-- > 0 ? 7 : 0);
    if ($state['poison']-- > 0)
        $state['boss'] -= 3;
    if ($state['recharge']-- > 0)
        $state['m'] += 101;

    if ($state['hp'] <= 0 OR $state['manaspent'] >= $min)
        continue;
    if ($state['boss'] <= 0) {
        $min = min($min, $state['manaspent']);
        continue;
    }

    if ($state['move'] == 'boss') {
        $state['move'] = 'player';
        $state['hp'] -= max(1, $state['d'] - $state['a']);
        array_unshift($moves, $state);
    } else {
        $state['move'] = 'boss';
        foreach ($spells as $spell => $info) {
            if ($info[0] >= $state['m']) continue;
            $n = $state;
            $n['m'] -= $info[0];
            $n['manaspent'] += $info[0];

            switch ($spell) {
                case 'missile':
                case 'drain':
                    $n['boss'] -= $info[1];
                    $n['hp'] += $info[2];
                    break;
                default:
                    if ($n[$spell] > 0) continue 2;
                    $n[$spell] = $info[1];
                    break;

            }

            array_unshift($moves, $n);
        }
    }
}

echo $min;