

### 命名空间的使用
在讨论如何使用命名空间之前，必须了解 PHP 是如何知道要使用哪一个命名空间中的元素的，可以将 PHP 命名空间与文件系统作一个简单的类比。

在文件系统中访问一个文件有三种方式：

1，相对文件名形式如foo.txt。它会被解析为 currentdirectory/foo.txt，其中 currentdirectory 表示当前目录。因此如果当前目录是 /home/foo，则该文件名被解析为/home/foo/foo.txt。

2，相对路径名形式如subdirectory/foo.txt。它会被解析为 currentdirectory/subdirectory/foo.txt。

3，绝对路径名形式如/main/foo.txt。它会被解析为/main/foo.txt。

-------------------------------------------------------------------------------------------------------

PHP 命名空间中的元素使用同样的原理。例如，类名可以通过三种方式引用：

1，非限定名称，或不包含前缀的类名称，例如 $a=new foo();。如果当前命名空间是 currentnamespace，foo 将被解析为 currentnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，则 foo 会被解析为foo。 

2，限定名称,或包含前缀的名称，例如 $a = new subnamespace\foo(); 或 subnamespace\foo::staticmethod();。如果当前的命名空间是 currentnamespace，则 foo 会被解析为 currentnamespace\subnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，foo 会被解析为subnamespace\foo。

3，完全限定名称，或包含了全局前缀操作符的名称，例如， $a = new \currentnamespace\foo(); 或 \currentnamespace\foo::staticmethod();。在这种情况下，foo 总是被解析为代码中的文字名(literal name)currentnamespace\foo。


-------------------------------------------------------------------------------------------------------

使用命名空间，别名导入

use My\Full\Classname as NSname;

// 下面的例子与 use My\Full\NSname as NSname 相同
use My\Full\NSname;

