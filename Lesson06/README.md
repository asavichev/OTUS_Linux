Переделал установку через скрипт запускаемый из vaпrant
сервис сканирования лога

systemctl start myscan.service


systemctl start httpd@httpd.service
systemctl start httpd@httpd1.service

Сервисы заработали оказывается невнимательно читал доку.
Помогла конструкция в apache.conf:

PidFile /run/httpd/httpd.pid
PidFile /run/httpd/httpd1.pid

Так же решился вопрос с запуском сервиса fastcgi
