<?php

$bossHP = 109;
$bossDmg = 8;
$bossArmor = 2;

$weapons = array(
    new Item(8, 4, 0),
    new Item(10, 5, 0),
    new Item(25, 6, 0),
    new Item(40, 7, 0),
    new Item(74, 8, 0)
);

$armor = array(
    new Item(13, 0, 1),
    new Item(31, 0, 2),
    new Item(53, 0, 3),
    new Item(75, 0, 4),
    new Item(102, 0, 5)
);

$rings = array(
    new Item(25, 1, 0),
    new Item(50, 2, 0),
    new Item(100, 3, 0),
    new Item(20, 0, 1),
    new Item(40, 0, 2),
    new Item(80, 0, 3)
);

$options = generateAllOptions($weapons, $armor, $rings);

$winningOptionsPrice = array();

foreach ($options as $option) {
    if(!optionWins($option, $weapons, $armor, $rings, $bossHP, $bossDmg, $bossArmor)) {
        $winningOptionsPrice[] = getOptionPrice($option, $weapons, $armor, $rings);
    }
}

echo max($winningOptionsPrice);


function generateAllOptions($weapons, $armorItems, $rings) {
    $options = array();

    foreach ($weapons as $weaponIndex => $weapon) {
        $options[] = $weaponIndex . ';;';

        foreach ($rings as $ringIndex => $ring) {
            $options[] = $weaponIndex . ';;' . $ringIndex;

            foreach($rings as $secondRingIndex => $secondRing) {
                if ($ringIndex !== $secondRingIndex) {
                    $options[] = $weaponIndex . ';;' . $ringIndex . ',' . $secondRingIndex;
                }
            }
        }

        foreach ($armorItems as $armorIndex => $armor) {
            $options[] = $weaponIndex . ';' . $armorIndex .';';

            foreach ($rings as $ringIndex => $ring) {
                $options[] = $weaponIndex . ';' . $armorIndex .';' . $ringIndex;

                foreach($rings as $secondRingIndex => $secondRing) {
                    if ($ringIndex !== $secondRingIndex) {
                        $options[] = $weaponIndex . ';' . $armorIndex .';' . $ringIndex . ',' . $secondRingIndex;
                    }
                }
            }
        }
    }

    return $options;
}

function optionWins($option, $weapons, $armor, $rings, $bossHP, $bossDmg, $bossArmor) {
    $ownHP = 100;
    $ownDmg = 0;
    $ownArmor = 0;

    $parts = explode(";", $option);

    $items = array();

    $items[] = $weapons[$parts[0]];

    if (strlen($parts[1]) !== 0) {
        $items[] = $armor[$parts[1]];
    }

    if (strlen($parts[2]) !== 0) {
        $ringParts = explode(',', $parts[2]);
        foreach ($ringParts as $ringPart) {
            $items[] = $rings[$ringPart];
        }
    }

    /** @var Item $item */
    foreach ($items as $item) {
        $ownDmg += $item->dmg;
        $ownArmor += $item->armor;
    }


    for ($i = 0; $i < 1000; $i++) {
        $bossHP -= $ownDmg - $bossArmor;

        if ($bossHP <= 0) {
            return true;
        }

        $ownHP -= $bossDmg - $ownArmor;

        if ($ownHP <= 0) {
            return false;
        }
    }

    return false;
}

function getOptionPrice($option, $weapons, $armor, $rings) {
    $parts = explode(";", $option);

    $items = array();

    $items[] = $weapons[$parts[0]];

    if (strlen($parts[1]) !== 0) {
        $items[] = $armor[$parts[1]];
    }

    if (strlen($parts[2]) !== 0) {
        $ringParts = explode(',', $parts[2]);
        foreach ($ringParts as $ringPart) {
            $items[] = $rings[$ringPart];
        }
    }

    $totalCost = 0;

    /** @var Item $item */
    foreach ($items as $item) {
        $totalCost += $item->cost;
    }

    return $totalCost;
}


class Item {
    public $cost;
    public $dmg;
    public $armor;

    public function __construct($cost, $dmg, $armor) {
        $this->cost = $cost;
        $this->dmg = $dmg;
        $this->armor = $armor;
    }
}