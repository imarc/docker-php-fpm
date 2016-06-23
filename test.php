<?php
// test only half implemented

$extensions = array_diff(
	[
		'Core',
		'date',
		'libxml',
		'openssl',
		'pcre',
		'sqlite3',
		'zlib',
		'ctype',
		'curl',
		'dom',
		'fileinfo',
		'filter',
		'hash',
		'iconv',
		'json',
		'mbstring',
		'SPL',
		'PDO',
		'session',
		'posix',
		'readline',
		'Reflection',
		'standard',
		'SimpleXML',
		'pdo_sqlite',
		'Phar',
		'tokenizer',
		'xml',
		'xmlreader',
		'xmlwriter',
		'mysqlnd',
		'gd',
		'imagick',
		'mcrypt',
		'memcached',
		'pdo_mysql',
		'pdo_pgsql',
		'Zend OPcache'
	],
	get_loaded_extensions()
);

