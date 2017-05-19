<?php


$contents = file_get_contents('aaaaaaaaa.txt');
preg_match_all('/<dd class="job_bt">(.*?)<\/dd>/s', $contents, $job_say);
// preg_match_all('/<div class=\"inner\">(.*?)/', $contents, $job_say);

$match_content = str_replace('&nbsp;', '', $job_say[1][0]);
$job_say = strip_tags($match_content);

print_r($job_say);
