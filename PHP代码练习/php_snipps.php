<?php

$b = 2;
echo json_encode([]);
$a = 1;
echo $a;


die;
function generateUserScore($score)
    {
        $preTime    =   strtotime('2017-7-15 00:00:00');
        $diff       =   substr(($preTime - time()), 0);
        $diff       =   strlen($diff) > 7 ? 9999999 : $diff;
        $suffix     =   str_repeat('0', 7 - strlen($diff));
        return $score . $suffix . $diff;
    }
echo generateUserScore(1);