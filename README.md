### [Git workflow](https://wiki.gentoo.org/wiki/Standard_git_workflow)

```
pkgdev manifest -d /tmp/distfiles
pkgdev commit
pkgdev push
```


### /etc/portage/repos.conf/fatty.conf

```
[fatty]
location = /var/db/repos/fatty
sync-type = git
sync-uri = https://github.com/brundage/gentoo-fatty-portage-overlay.git
auto-sync = yes
```
