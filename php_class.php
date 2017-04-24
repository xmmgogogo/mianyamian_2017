<?php

class redis {
    public function add($v) {
        echo "redis add " . $v;
    }

    public function del($v) {
        echo "redis del " . $v;
    }
}

class memcache {
    public function add($v) {
        echo "memcache add " . $v;
    }

    public function del($v) {
        echo "memcache del " . $v;
    }
}

class cache {
    public $client = '';

    public  function __construct($set_value) {
        $this->client = $set_value;
    }

    public  function add($v) {
        $this->client->add($v);
    }

    public  function del($v) {
        $this->client->del($v);
    }
}

$cache = new cache(new memcache());
$cache->add('aaaa');