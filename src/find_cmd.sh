in_path()
{

# Given a command and PATH, tries to find the command. Returns 0 if found and executable, 
# 1 if not. Note that this temporarily modifies the field separator but resets it once at
# the end of execution.

cmd=$1 ourpath=$2 result=1 
oldIFS=$IFS IFS=":"

for directory in "$ourpath"
do
	if [ -x $directory/$cmd ]; then 
	  result = 0
	fi
done

IFS=$oldIFS
return $result

}


check_for_cmd_in_path()
{

	var=$1
	
	if [ "$var" != "" ]; then
	  if [ "${var:0:1}"="/" ]; then
	  	if [ ! -x "$var" ]; then
	  	  return 1
	  	fi
	elif ! in_path $var "$PATH"; then
		return 2
	fi
  fi
}

if [ $# -ne 1 ];  then
	echo "Usage: $0 command" >&2
	exit 1
fi

check_for_cmd_in_path "$1"
case $? in 
	0 ) echo "$1 found in PATH"	;;
	1 ) echo "$1 not found or not executable" ;;
	2 ) echo "$1 not found in PATH"	;;
esac 

exit 0