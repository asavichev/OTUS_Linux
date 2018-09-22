PAM
1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни
скриптом создаем группу admin и пользователя test входящего в эту группу
спомощью скрипта(pam_script) log_acct запрещаем вход пользователей не входящих в оговоренную группу

2. Дать конкретному пользователю права рута


sudo /sbin/capsh --keep=1 --caps="cap_sys_admin+epi" --print -- -c "/bin/bash"

[test@otuslinux ~]$ sudo /sbin/capsh --keep=1 --caps="cap_sys_admin+epi" --print -- -c "/bin/bash"
Current: = cap_sys_admin+eip
Bounding set =cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,35,36
Securebits: 020/0x10/5'b10000
 secure-noroot: no (unlocked)
 secure-no-suid-fixup: no (unlocked)
 secure-keep-caps: yes (unlocked)
uid=0(root)
gid=0(root)
groups=0(root)
[root@otuslinux test]#