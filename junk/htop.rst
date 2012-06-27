********************
Htop or Linux Memory
********************
Help, Linux ate my RAM: http://webcache.googleusercontent.com/search?q=cache:http://www.linuxatemyram.com/

RAM available = free + buffers + cache

Htop http://htop.sourceforge.net/index.php?page=faq

Colors (F1 in htop): 

- green: processes (=RES in column)
- blue: buffers
- orange: cache

Difference between buffers and cache: http://www.linuxhowtos.org/System/Linux%20Memory%20Management.htm

- Buffers hold file system meta data
- Cache holds file contents

Get available RAM one-liner::

    free -m | awk '/cache:/ {print $4}'

