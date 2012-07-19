FS2 Open From Gog.com on Ubuntu 12.04
=====================================
innoextract to extract fs2 data files from gog's setup file::

    git clone git://github.com/dscharrer/InnoExtract.git
    sudo apt-get install libboost-iostreams-dev libboost-filesystem-dev libboost-date-time-dev libboost-system-dev libboost-program-options-dev cmake liblzma-dev
    cd InnoExtract
    mkdir -p build && cd build && cmake ..
    make
    cp innoextract ~/bin/

target::

    mkdir -p ~/games/freespace2/

extract installer files::

    cd /tmp/
    mkdir fs2installer
    innoextract ~/downloads/fs2/setup_freespace_2.exe

mv files to target::

    mv Root_fs2.vp smarty_fs2.vp sparky_fs2.vp sparky_hi_fs2.vp stu_fs2.vp tango1_fs2.vp tango2_fs2.vp tango3_fs2.vp warble_fs2.vp ~/games/freespace2/
    mkdir ~/games/freespace2/movies/
    mv data2/COLOSSUS.MVE data2/INTRO.MVE data2/MONO1.MVE data3/BASTION.MVE\
       data3/ENDPART1.MVE data3/ENDPRT2A.MVE data3/ENDPRT2B.MVE\
       data3/MONO2.MVE data3/MONO3.MVE data3/MONO4.MVE\
       ~/games/freespace2/movies/

ogg cut scenes::

    cd ~/downloads/fs2
    wget http://www.freespacemods.net/e107_files/downloads/fs2_ogg.zip
    unzip fs2_ogg.zip -d cutscenes
    mv cutscenes/* ~/games/freespace2 && rmdir cutscenes

download media files::

    cd ~/downloads/fs2
    mkdir media && cd media
    wget http://mvp.fsmods.net/3612/MediaVPs_3612.zip
    wget http://mvp.fsmods.net/3612/MV_Root_3612.zip
    wget http://mvp.fsmods.net/3612/MV_Root_Update.zip
    wget http://mvp.fsmods.net/3612/MV_Music_3612.zip
    wget http://mvp.fsmods.net/3612/MV_Assets_3612.zip
    wget http://mvp.fsmods.net/3612/MV_Assets_Update.zip
    wget http://mvp.fsmods.net/3612/MV_Effects_3612.zip
    wget http://mvp.fsmods.net/3612/MV_Effects_Update.zip
    # for high performance machines
    wget http://mvp.fsmods.net/3612/MV_Advanced_3612.zip
    wget http://mvp.fsmods.net/3612/MV_AnimGlows_3612.zip
    wget http://mvp.fsmods.net/3612/MV_RadarIcons_3612.zip
    wget http://mvp.fsmods.net/3612/MV_CB_ANI_1.zip
    wget http://mvp.fsmods.net/3612/MV_CB_ANI_2.zip

    # extract
    unzip MV_CB_ANI_1.zip -d mediavps_3612/
    unzip MV_CB_ANI_2.zip -d mediavps_3612/
    unzip MV_Advanced_3612.zip
    unzip MV_AnimGlows_3612.zip
    unzip MV_Assets_3612.zip
    unzip MV_Assets_Update.zip
    mv MediaVPS_3612/MV_Assets.3612.vp mediavps_3612/ && rmdir MediaVPS_3612/
    unzip MV_Effects_3612.zip
    unzip MV_Effects_Update.zip
    mv MediaVPS_3612/MV_Effects.3612.vp mediavps_3612/ && rmdir MediaVPS_3612/
    unzip MV_Music_3612.zip
    unzip MV_RadarIcons_3612.zip
    unzip MV_Root_3612.zip
    unzip MV_Root_Update.zip
    mv MediaVPS_3612/MV_Root.3612.vp mediavps_3612/ && rmdir MediaVPS_3612/

    mv mediavps_3612/ ~/games/freespace2/

build fs2open::

    wajig install autoconf automake libogg-dev vorbis-tools libvorbis-dev libtheora-dev liblua5.1-0-dev libjpeg-dev
    svn checkout svn://svn.icculus.org/fs2open/trunk/fs2_open
    cd fs2_open
    ./autogen.sh
    make
    cp code/fs2_open_3.6.13 ~/games/freespace2/
    cat <<'EOF' > $HOME/bin/fs2
    cd ~/games/freespace2/
    ./fs2_open_3.6.13 -spec -glow -mipmap -jpgtga -orbradar -mod mediavps_3612
    EOF
    chmod +x HOME/bin/fs2
    fs2


Links
-----
- http://diaspora.hard-light.net/links.html
- configure by hand http://www.hard-light.net/wiki/index.php/Fs2_open_on_Linux/Graphics_Settings

