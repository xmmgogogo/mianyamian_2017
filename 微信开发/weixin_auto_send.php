<?php
/**
 * Created by PhpStorm.
 * User: mm
 * Date: 2017/12/27
 * Time: 17:27
 */

// 指定发送用户
$OPEN_ID = [
    "of0E4uAfA81r4DzpuUJMHz99PZCY", // lmm
];

RUNSTART:

// TOKEN这个值会变化
if(empty($TOKEN) || empty($TOKEN_EXPIRE_TIME) || $TOKEN_EXPIRE_TIME < time()) {
    $APP_id = 'wx453b2a29ec7ff783';
    $APP_secret = '90368c784e6be1ed081ce3e7e57fec30';
    $TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";
    $token_res = file_get_contents(sprintf($TOKEN_URL, $APP_id, $APP_secret));
    if($token_res) {
        $token_res = json_decode($token_res, true);
    }

    //$TOKEN = '5_bMDbup0anug7VvOnbhUMLL8vSaPuCvR_x5UYRncsNeyMQJFyvYhDQth0qvpHVatabi4aEK28QYacgosTAUMq3P9_7qa8ir7VZVdci2v_iOSMG_AtJjFz3VApOwPPE0pzDTRr1Ux1zJQ7WroOOMHbAHAUSN';
    $TOKEN = $token_res['access_token'];
    $TOKEN_EXPIRE_TIME = time() + 7000;
}

// 发送URL
$url = sprintf('https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=%s', $TOKEN);

// 发送内容
$content = yi_chang_check();
if($content) {
    foreach ($OPEN_ID as $open_id) {
        $DATA = '{"touser": "' . $open_id . '","msgtype": "text", "text": {"content": "' . $content . '"}}';
        $ret = curl_post($url, $DATA);
        var_dump([$url, $DATA]);
        echo $open_id . '-->' . $ret . PHP_EOL;
    }
} else {
    echo "nothing..." . PHP_EOL;
}

sleep(60);

// 继续执行代码
goto RUNSTART;

function curl_post($url, $rawData)
{
    $headers = array("Content-Type: text/xml; charset=utf-8");
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $rawData);
    $output = curl_exec($ch);
    curl_close($ch);
    return $output;
}

function yi_chang_check() {
    // 先判断文件啥的 TODO
    // 其实以后可以把全部错误和异常写到一个固定的文件，这样每次直接读取文件，就好了
    $content = date('Y-m-d H:i:s') . ' - 【系统出现异常】' . PHP_EOL . PHP_EOL;
    $value = shell_exec('ls /tmp/dsp_shell/web_dsp_exception_*');
    if($value) {
        $content .= $value;
    } else {
        $content = '';
    }

    // 检测文件

    return $content;
}