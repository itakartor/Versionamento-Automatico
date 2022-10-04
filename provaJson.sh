LAST_TAG=$(git describe) #ultimo tag di git
#BETA=$(json -f package.json beta) #prendo il valore di beta dal package
read -p ${LAST_TAG}
BETA=$(echo $LAST_TAG| cut -d'.' -f 4) #vedo se sono nella beta attraverso il tag
BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5) #versione della beta da recuperare in caso che ci sia
read -p ${BETA}
read -p "la release che stai facendo è una beta(y/n)" response
read -p $response
read -p ${BETAVERSION}
if [ $BETA != "beta" ]  #ero fuori dalla beta
then
	echo "non sono in beta"
else
	echo "sono in beta"
fi
read -p "Press enter to continue"

if [ ${BETA} != "beta" ] #ero fuori dalla beta
then
	echo "non sono nella beta"
	if [ $response = "y" ]
	then #sto entrando nella beta
		json -I -f package.json -e "this.beta=true"
		json -I -f package.json -e "this.betaCouter+=1"
	else
		if [ $response = "n" ]
		then #sono gia fuori dalla beta allora devo solo incrementare la minor
			json -I -f package.json -e "this.versionC=this.versionC+1"
		fi
	fi
else #sono nella beta
	if [ ${BETA} = "beta" ]
	read -p "in beta"	
	then
		if [ $response = "y" ]
		then #ci sono gia e voglio rimanerci 
			read -p "y"
			json -I -f package.json -e "this.beta=true"
			BETAVERSION=1
			#BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5)
			#BETAVERSION=$((BETAVERSION+1)) #incremento la versione e gliela passo
			read -p ${BETAVERSION}
			#json -I -f package.json -e "this.betaCouter = ${BETAVERSION}"
		else
			if [ $response = "n" ]
			then #sto uscendo dalla beta
				read -p "n"
				#json -I -f package.json -e "this.beta=false"
				#json -I -f package.json -e "this.betaCouter=0"
			
			fi
		fi
	fi
fi
