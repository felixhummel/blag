echo "This file: $0"
echo "Absolute path of this file: $(readlink -f $0)"
echo "Absolute path of this file's parent directory: $(dirname $(readlink -f $0))"
