#!/bin/bash
mk='Makefile'
name=$1
cflag=''
if [ ! $# -ge 2 ]
then
	echo "Invalid arguments count"
else
	
	if [ $# -gt 2 ]
	then
		cflag=`./makehelp.py $@`
	fi
	
	cd $2
	
	mkdir build
	
	if [ -e $mk ]
	then
		echo "File already exist"
		rm $mk 
		echo "Deleted"
	fi	
		echo "Creating $mk file"
		echo -n "$name:">> $mk	
		for file in *.cpp
		do
			help=`echo -n "$file" | cut -d '.' -f 1`
			echo -n " $help" >> $mk
			echo -n ".o" >> $mk
		done
		
		echo >> $mk
		
		echo -e -n "\tg++" >>$mk
		for file in *.cpp
		do
			help=`echo -n "$file" | cut -d '.' -f 1`
			echo  -n " ./build/$help.o" >> $mk
		done
		echo " -o $name $cflag" >> $mk
		
		echo >> $mk
		
		for file in *.cpp
		do
			help=`echo -n "$file" | cut -d '.' -f 1`
			echo "$help.o: $file" >> $mk
			echo -e "\tg++ -c $file -o ./build/$help.o\n" >> $mk
		done
		echo -e "clean:\n\trm ./build/*.o $name" >> $mk
	


fi