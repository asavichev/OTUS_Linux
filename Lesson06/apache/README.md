�� ���� ��� ���������� ������ apache �� ������
yum install httpd -y
������ ������ ���� ������������ � ���������� ����������� �� ������ ����
��� ������� ������� �� ������� �������� ������������� ��������� apache 
��� ������� � ���� �� ����� apache.com 
PidFile=/run/httpd/httpd.pid - �� �������� ����

������� ������ � google �������� ���� ��������� ������ �� �������.

DEFAULT_PIDLOG=/run/httpd/httpd1.pid
PIDLOG=/run/httpd/httpd1.pid
APACHE_PID_FILE=/run/httpd/httpd1.pid

�������������� ��� ������ ������� ��� ��������� ������� httpd
systemctl start httpd@httpd1.service
�� ����������� ��� ��� ������ � ����� ��� ����������. ���� ���������� ������ httpd
�� ������ ����������� �� �������������� ����� �� ������ ��� ������� �� �����.
��� ��� ��� �������� ������ ���� PID � /run/httpd/httpd.pid.