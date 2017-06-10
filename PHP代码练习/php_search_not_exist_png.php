<?php

$file_path = "E:/vikingage-release-svn-down/vikingage-ag.shinezone.com/release/images/armorIcon";

for($i = 3; $i <= 1000; $i++) {
	if(!file_exists($file_path . "/armatar_{$i}_100.100_c.png")) {
		echo "({$i}) faild" . PHP_EOL;

		//拷贝一份出来
		copy($file_path . '/armatar_3_100.100_c.png', $file_path . "/../../armatar_{$i}_100.100_c.png");
	}
}