<?php


$images = [
    [
        'url' => 'https://dn-phphub.qbox.me/uploads/images/201612/10/1/k7wwMpJduq.jpg'
    ],
    [
        'url' => 'https://dn-phphub.qbox.me/uploads/images/201612/10/1/k7wwMpJduq.jpg'
    ],
    [
        'url' => 'https://dn-phphub.qbox.me/uploads/images/201612/10/1/k7wwMpJduq.jpg'
    ],
];

$neirong = '<!--{img:0}-->|<!--{img:1}-->|<!--{img:2}-->';
$title='test';


$j=0;
foreach ($images as $key => $value) {
    $neirong = str_replace('<!--{img:'.$j.'}-->', '<img src="'.$value['url'].'" alt="'.$title.'" />', $neirong);
    $j++;
}

echo $neirong;


for ($i=0; $i <1; $i++) {
}
