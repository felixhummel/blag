Testbox Setup
=============
::

    cd ~/.ssh/keys
    ssh-keygen -C 'Test box' -N '' -f testbox
    scp root@testbox testbox:.ssh/id_rsa
    scp root@testbox.pub  testbox:.ssh/id_rsa.pub

    cd ~/gitolite-admin/
    cp ~/.ssh/keys/root@testbox.pub keydir/root_testbox.pub
    vim conf/gitolite.conf
    git commit -m "add root@testbox"

