<?php

$xml = simplexml_load_file("config.xml");

foreach($xml->attributes() as $a => $b)
{
    echo $a,'="',$b,'"';
}
