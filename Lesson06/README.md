��������� ��������� ����� ������ ����������� �� va�rant
������ ������������ ����

systemctl start myscan.service


systemctl start httpd@httpd.service
systemctl start httpd@httpd1.service

������� ���������� ����������� ������������� ����� ����.
������� ����������� � apache.conf:

PidFile /run/httpd/httpd.pid
PidFile /run/httpd/httpd1.pid

��� �� ������� ������ � �������� ������� fastcgi
