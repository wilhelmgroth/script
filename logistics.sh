#!/bin/bash

# Wilhelm Groth
# 2021-04-15
# DT011G

# Typ global variabel för parameter 1 (Filnamn i detta fall)
filename=${1}

# Funktion för att läsa in filnamn
function readfile()
{

if [[ -e "$filename" ]]; then
        FILENAME=${filename}
    else
        read  -p "Vilken datafil vill du använda? ---> " FILENAME
        if [[ -e "${FILENAME}" ]]; then
            clear
           else 
		echo "Din fil finns inte..."
		echo "Avslutar..."
		sleep 2
		exit
	 fi
fi


}

# Usage/Help funktion
function help()
{
		clear
		echo "Används för logistikhantering."
		echo "Syntax: logistics FILE [-b | -p | -s {i|n|v|l|b|h}]"
		echo
		echo "-b	Genererar en säkerhetskopia av datafilen i samma katalog."
		echo "-p	Skriver ut innehållet i datafilen."
		echo "-s	Sorterar och skriver ut innehållet i datafilen."
		echo "		 i efter produktnummer		n efter namn"
		echo "		 v efter vikt			l efter längd"
		echo "		 b efter bredd 		h efter höjd"
		echo
		echo "--help	Skriver ut den här hjälptexten."
		echo
		
	
}


case $1 in 
	--help)
		help
		exit
		
	;;

esac



case $2 in
	--help)
		help
		exit
	;;
	
	-b)
		clear
		echo
		echo "Backup initiated."
		cp $filename $filename.backup
		sleep  1
		echo "Loading the quantum computer..."
		sleep 3
		echo "Time 55% reversed... "
		sleep 2
		echo "Shor's quantum algorithm completed. Time is reversed. Backup completed."
		sleep 1
		exit
		
	;;

	-s)
		
		echo "Sort"
		echo
		
		if [ $3 == -n ]; 
			then
				head -n 1 < $1 # head för att läsa första raden i txtfilen  https://baeldung.com/linux/head-tail-commands
				tail -n +2  $1 | sort -k2  | tr "_" " "  # tail för att läsa till innan rubriken

		else 
			if [ $3 == -i ]
				then 
					sort -n -k1 $1 | tr "_" " " # transform för att transorma underline till spaces
			elif [ $3 == -v ]			     # https://www.geeksforgeeks.org/tr-command-in-unix-linux-with-examples/
				then
					sort -n -k3 $1 | tr "_" " "

			elif [ $3 == -l ]
				then
					sort -n -k4 $1 | tr "_" " "
		
			elif [ $3 == -b ]
				then
					sort -n -k5 $1 | tr "_" " "
		
			elif [ $3 == -h ]
				then
					sort -n -k6 $1 | tr "_" " "
	
		
		fi
	fi
	echo
	exit
;;
	
	-p)	# Skriver ut datafilen 
		echo 	
		cat $1 | tr "_" " "
		echo
		exit
	::
esac


readfile # ber användaren skriva in sin datafil. Nedan börjar interaktiva läget. 

x=1
while [ $x = 1 ]
do
	clear
	echo
	echo " MENY "
	echo 
	echo " 0 - Avsluta"
	echo " 1 - Visa filen"
	echo " 2 - Sortera"
	echo " 3 - Backup"
	echo " 4 - Hjälp"
	echo
	echo -n " Ditt val:  "
	read val
	
	case $val in
	
		0)
			clear
			echo "Avslutar..."
			sleep 2
			clear
			x=0
		;;
	
		1)	clear
			echo
			cat $FILENAME | tr "_" " "
			echo
			echo "Tryck för att fortsätta...."
			
		;;
		
		2)	clear
			echo
			echo "Sortera"
			echo
			echo " 1- ID"
			echo " 2- Namn"
			echo " 3- Vikt"
			echo " 4- Längd"
			echo " 5- Bredd"
			echo " 6 -Höjd"
			echo "Ange hur du vill sortera: "
			echo -n "Ditt val: "
			read sort
			clear
			echo 
			
			## -eq om sort lika med heltalet 2
			if [[ $sort -eq 2 ]]
			then
				head -n 1 < $FILENAME # head för att läsa första raden i txtfilen
				tail -n +2 $FILENAME | sort -k$sort | tr "_" " " #tranformar alla underline till spaces 
			
			else
				sort -n -k$sort $FILENAME | tr "_" " "
			fi
			echo
			echo "Tryck för att fortsätta..."
		;;
			
	
		3)	clear
			echo
			echo "Backup initiated"
			cp $FILENAME $FILENAME.backup
			sleep  1
			echo "Loading the quantum computer.."
			sleep 3
			echo "Time 55% reversed... "
			sleep 2
			echo "Shor's quantum algorithm completed. Time is reversed. Backup completed."
			echo
			sleep 1
			echo "Tryck för att fortsätta..."
			
		;;
		
		4)	
			help
			echo "Tryck för att fortsätta..."
		;;
		
		*) 	clear
			echo
			echo "Ajdå.... Försök igen!"
			echo
	esac
	read dummyline # detta för att förhindra att loopa för snabbt
done
