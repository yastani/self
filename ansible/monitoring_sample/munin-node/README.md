リソース監視(Munin-Server)の各種設定方法
# リソース監視とは…
現在利用しているサーバーのリソース状況をリアルタイムに表示するサービス。
グラフィカルな表示により視認性が高く、アクセス数やディスク使用量の変動によるシステム障害の予防・早期発見に役立てられる。

## 一般的に監視するリソースの種類
- CPU使用状況
- メモリー使用状況
- 負荷状況
- トラフィック状況
- プロセス状況
- ディスク使用状況

## 監視サーバー
### 監視対象を追加する方法
自身のリソース情報を監視サーバーに送信する「munin-node」を監視対象にインストールする必要がある。
また、ApacheやNginx、PHP-FPM、RDSなどシステムを稼働させる基盤となるサービスに関しては
別途各プロセスを監視できるようにする追加設定が必要となる。

### アラートメールの送信設定
```
sudo vim /etc/munin/munin.conf

+ contact.adminuser.command mail -s "[${var:group};${var:host}] -> ${var:graph_title} -> warnings: ${loop<,>:wfields  ${var:label}=${var:value}} criticals: ${loop<,>:cfields  ${var:label}=${var:value}}" hoge@example.com
+ contact.adminuser.max_messages 1
+ contact.adminuser.always_send warning critical
```

### アラートルールの設定
```
sudo vim /etc/munin/conf.d/server.conf

+ [Munin-Server;localhost]
+ address 127.0.0.1
+ use_node_name yes
+ cpu.user.warning 70
+ cpu.user.critical 80
………
```

## 監視ノード
### AWS セキュリティグループ
- Listen Port
  - Inbound
    - 4949/TCP
      - 192.168.1.1/32
    - 4949/UDP
      - 192.168.1.1/32

### munin-nodeを導入する方法

#### AmazonLinux.201703

##### munin-nodeで通常監視する場合
```
# インストール
sudo yum install -y munin-node

# 起動
sudo service munin-node start
sudo chkconfig munin-node on

# Munin-Serverからの接続を許可する
sudo vim /etc/munin/munin-node.conf

- host_name localhost.localdomain
+ host_name example.com # このサーバで使用されているホスト名

+ allow ^192\.168\.1\.1$
```

##### Apacheプロセスを監視する場合
```
# シンボリックリンク作成
sudo ln -s /usr/share/munin/plugins/apache_accesses /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/apache_processes /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/apache_volume /etc/munin/plugins/

# munin-nodeを再起動
sudo service munin-node restart

# status.confを新規作成
sudo vim /etc/httpd/conf.d/status.conf

+ <IfModule mod_status.c>
+ ExtendedStatus On
+   <Location /server-status>
+     SetHandler server-status
+     Order deny,allow
+     Deny from all
+     Allow from 127.0.0.1
+   </Location>
+ </IfModule>

# Apacheを再起動
sudo service httpd restart

# Apacheのステータスが取得できることを確認
sudo curl http://localhost/server-status
```

##### Nginxプロセスを監視する場合
```
# シンボリックリンク作成
sudo ln -s /usr/share/munin/plugins/nginx_request /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/nginx_status /etc/munin/plugins/

# munin-node.confに設定を追加
sudo vim /etc/munin/plugin-conf.d/munin-node

+ [nginx*]
+ env.url http://localhost/nginx_status

# munin-nodeを再起動
sudo service munin-node restart

# Serverディレクティブの下に下記を追加
sudo vim /etc/nginx/conf.d/virtual.conf

+ location /nginx_status {
+   stub_status on;
+   access_log off;
+   allow 127.0.0.1;
+   deny all;
+ }

# Nginxを再起動
sudo service nginx restart

# Nginxのステータスが取得できることを確認(port:80以外であれば指定すること)
sudo curl http://localhost/nginx_status
```

##### PHP-OPCacheプロセスを監視する場合
```
# PHP-OPCacheのプラグインをダウンロード
cd /usr/share/munin/plugins
sudo git clone git://github.com/nyroDev/munin-php-opcache.git

# 実行権限を付与
sudo chmod +x /usr/share/munin/plugins/munin-php-opcache/php_opcache_

# シンボリックリンク作成
sudo ln -s /usr/share/munin/plugins/munin-php-opcache/php_opcache_ /etc/munin/plugins/

# OPCacheのプロセス値を取得するスクリプトをドキュメントルートに設置
sudo cp -p /usr/share/munin/plugins/munin-php-opcache/php_opcache.php /var/www/html/

# munin-node.confに設定を追加
sudo vim /etc/munin/plugin-conf.d/munin-node

+ [php_opcache_*]
+ env.url http://localhost/php_opcache.php

# php_opcache.confを新規作成(Nginxの場合)
sudo vim /etc/nginx/conf.d/virtualhost.conf

+ location ~ php_opcache\.php$ {
+   allow 127.0.0.1;
+   deny all;
+ }

# Nginxを再起動
sudo service nginx restart

# PHP-OPCacheのステータスが取得できることを確認
curl http://localhost/php_opcache.php
```

##### PHP-FPMプロセスを監視する場合
```
# PHP-FPMのプラグインをダウンロード
cd /usr/share/munin/plugins
sudo git clone git://github.com/tjstein/php5-fpm-munin-plugins.git

# シンボリックリンク作成
sudo ln -s /usr/share/munin/plugins/php5-fpm-munin-plugins/phpfpm_average /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/php5-fpm-munin-plugins/phpfpm_connections /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/php5-fpm-munin-plugins/phpfpm_memory /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/php5-fpm-munin-plugins/phpfpm_processes /etc/munin/plugins/
sudo ln -s /usr/share/munin/plugins/php5-fpm-munin-plugins/phpfpm_status /etc/munin/plugins/

# munin-node.confに設定を追加
sudo vim /etc/munin/plugin-conf.d/munin-node

+ [phpfpm*]
+ env.url http://localhost/phpfpm_status
+ env.phpbin php-fpm

# PHP-FPMのstatusを確認できるようにする
- ;pm.status_path = /status
+ pm.status_path = /phpfpm_status

# Serverディレクティブの下に下記を追加(Nginxの場合)
sudo vim /etc/nginx/nginx.conf

+ location /phpfpm_status {
+   include fastcgi_params;
+   fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
+   fastcgi_param SCRIPT_FILENAME /var/www/html/php$fastcgi_script_name;
+   allow 127.0.0.1;
+   deny all;
+ }

# PHP-FPMを再起動
sudo service php-fpm restart

# PHP-FPMのステータスが取得できることを確認
curl http://localhost/phpfpm_status
```

### 一般的な「t2.microインスタンス」にアラートルールの閾値設定をする場合の表
最終更新日：2017/05/19

| Category    | Resource Name                     | Warning Threshold | Critical Threshold | Description |
|:------------|----------------------------------:|:-----------------:|:------------------:|:-:|
| System      | Load average                      | CPUコア数☓1         | CPUコア数☓1.2 | 1CPUにおける単位時間あたりの実行待ちとディスクI/O待ちのプロセスの数 |
| System      | CPU usage.user                    | 70%    | 80%  | PHP/Apacheなどの使用量 |
| System      | CPU usage.iowait                  | 70%    | 80%  | DiskへのR/W |
| System      | CPU usage.system                  | 70%    | 80%  | OSが占有する使用量 |
| System      | Memory usage.apps                 | 70%    | 80%  | ユーザアプリ使用メモリサイズ |
| System      | Memory usage.swap                 | 25%    | 50%  | スワップとして使用されている量 |
| System      | Individual interrupts             | none   | none | 様々な割り込み処理 |
| System      | Inode table usage                 | none   | none | メモリIノード数および使用数 |
| System      | Interrupts and context switches   | none   | none | 処理された割り込み回数 |
| System      | Logged in users                   | none   | none | ログインユーザー数 |
| System      | Swap in/out                       | none   | none | 1秒間にswap in/outされたブロック数 |
| System      | Uptime                            | none   | none | 起動してから現在までの時間 |
| System      | Available entropy                 | none   | none | ランダム文字列の生成余剰 |
| System      | File table usage                  | none   | none | オープンされているファイル数とシステム中のオープンファイル管理データの最大数 |
| Disk        | Disk IOs per device               | none   | none | １秒間で行ったI/O数の平均値 |
| Disk        | Disk latency per device           | none   | none | 全ディスクの読み書きにかかる時間 |
| Disk        | Disk throughput per device none   | none   | none | １秒間に読み書きしたバイト数 |
| Disk        | Disk usage in percent             | 70%    | 80%  | ファイルシステムごとのディスク使用率 |
| Disk        | Disk utilization per device none  | none   | none | 全ディスクのIO使用率 |
| Disk        | Inode usage in percent            | none   | none | ファイルシステムごとのinode使用率 |
| Disk        | IO Service time                   | none   | none | デバイスごとの書き込み/読み込みの遅れ |
| Disk        | IOstat                            | none   | none | デバイスごとの書き込み能力 |
| Network     | eth0 errors                       | none   | none | パケットのエラー数 |
| Network     | eth0 traffic                      | none   | none | パケットの転送量(inがマイナス、outがプラス) |
| Network     | Firewall Throughput               | none   | none | １秒間に転送したパケット数 |
| Network     | Netstat                           | none   | none | - |
| Network     | HTTP loadtime of a page           | 6s     | 10s  | 任意のURLをwgetにて取得、その時間をtimeコマンドで取得し表示 |
| processes   | Fork rate                         | none   | none | 1秒間にforkされた数 |
| processes   | Number of threads                 | none   | none | スレッドがシステム全体でいくつ作られたか |
| processes   | Processes                         | 80%    | 90%  | プロセスの総数 |
| processes   | Processes priority                | none   | none | プロセスの優先度ごとの数 |
| processes   | VMstat                            | none   | none | 実行中であるプロセス数、スリープ状態にあるプロセス数 |
| Apache      | Apache accesses                   | none   | none | Apacheサーバのアクセス数 |
| Apache      | Apache processes                  | 80%    | 90%  | Apacheサーバのプロセス数 |
| Apache      | Apache volume                     | none   | none | Apacheサーバの転送量 |
| nginx       | Nginx requests                    | none   | none | Nginxサーバのリクエスト数 |
| nginx       | Nginx status                      | none   | none | Nginxサーバの状態 |
| PHP-FPM     | PHP-FPM Accepted Connections      | none   | none | PHP-FPMの許容されたコネクション数 |
| PHP-FPM     | PHP-FPM Average Process Size      | none   | none | PHP-FPMの平均的なプロセスの大きさ |
| PHP-FPM     | PHP-FPM Memory Usage              | 70%    | 80%  | PHP-FPMの仮想メモリ使用量 |
| PHP-FPM     | PHP-FPM Processes                 | 70%    | 80%  | PHP-FPMのプロセス数 |
| PHP-FPM     | PHP-FPM Status                    | none   | none | PHP-FPMの状態 |

### 監視サーバーで設定するアラートルール例
>        cpu.user.warning 70
>        cpu.user.critical 80
>        cpu.iowait.warning 70
>        cpu.iowait.critical 80
>        cpu.system.warning 70
>        cpu.system.critical 80
>        memory.apps.warning 751619276
>        memory.apps.critical 858993459
>        memory.swap.warning 25
>        memory.swap.critical 50
>        load.load.warning 1
>        load.load.critical 1.2
>        df._dev_xvda1.warning 70
>        df._dev_xvda1.critical 80
>        uptime.uptime.critical 0.01:
>        apache_processes.free80.warning 50:
>        apache_processes.free80.critical 25:
>        ps_httpd.count.critical 1
>        ps_nginx.count.critical 1
>        php_fpm.memory.warning 70
>        php_fpm.memory.critical 80
>        php_fpm.processes.warning 5
>        php_fpm.processes.critical 45