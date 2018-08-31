[root@otuslinux ansible]# ansible-playbook nginx.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [nginx : Installing nginx server] *****************************************
changed: [localhost]

TASK [nginx : Start and enable nginx] ******************************************
changed: [localhost]

TASK [nginx : Sets Port 8080 ip4] **********************************************
changed: [localhost]

TASK [nginx : Sets Port 8080 ip6] **********************************************
changed: [localhost]

RUNNING HANDLER [nginx : restart nginx] ****************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=5    unreachable=0    failed=0
