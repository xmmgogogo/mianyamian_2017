<?php

function fun_add($a, $b) {
    echo $a + $b;
}

function fun_max($a, $b, $fun) {
    $fun($a, $b);
}




$fn_add = function($a, $b) {
    echo $a + $b;
};

// $a();

// fun_max(2, 3, $fn_add);

$a = 2; $b =4;

echo 2 % 5;