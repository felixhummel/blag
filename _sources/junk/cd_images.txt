******************
Mounting CD Images
******************
CDEmu should make this trivially easy, but since there are no x64 packages yet, here are the manual approaches.

.. highlight:: bash

ISO Images
==========
::

    image=
    mountpoint=
    mkdir -p $mountpoint || sudo mkdir -p $mountpoint
    sudo mount -o loop,users $image $mountpoint
    cd $mountpoint

Bin/Cue
=======
::

    bin=
    cue=
    iso=
    bchunk $bin $cue $iso || wajig install bchunk && bchunk $bin $cue $iso
