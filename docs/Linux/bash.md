bash -X <script name>   # Debug
#!/bin/bash
echo -e "Enter your name: \c"
read answer
echo "Hello $answer"
exit 0
#!/bin/bash
echo "Hello $1"
exit 0
--------------------------------------------------------------------------
Return Value $?
0 Success Not 0 Failure
--------------------------------------------------------------------------
#!/bin/bash
if(($# < 1))
  then
    echo "Usage: $0 <name>"
	exit 1
fi
echo "Hello $1"
exit 0
--------------------------------------------------------------------------
case $1 in 
    "directory")
	    find /etc -maxdepth 1 -type d
		;;
	"link")
	    find /etc -maxdepth 1 -type l
		;;
	*)
	    echo "Usage: $0 directory | link"
		;;
esac
--------------------------------------------------------------------------
if (( $# < 1 )) ; then
		echo "Usage $0 <name>"
		exit 1
	elif [ $# -gt 1 ]
		echo "Hello $1"
		exit 0
	else
		echo "Hello $1"
		exit 0
fi
echo "Hello $1"
exit 0
--------------------------------------------------------------------------
```