#!/bin/bash
#1 per mettere il tag seguente all'ultima versione all'ultimo commit 1.0.0 -> 1.0.1
#2 con beta, alfa, omega
echo "1 per taggare l'ultimo commit con la versione"
#for i in 1 2 3 4 5 6 7 8 9
#do per ora aumenta solo l'ultimo numero della versione
#devo capire come aumentare quella in mezzo e in caso come sostituire se viene messa una versione beta, ecc
#devo verificare se l'utente vuole entrare o uscire dalla beta oppure rimanere
#quindi vorrei verificare se all'entrata trovo true o false al flag beta
LAST_TAG=$(git describe) #ultimo tag di git
#BETA=$(json -f package.json beta) #prendo il valore di beta dal package
read -p "Press enter to continue"
BETA=$(echo $LAST_TAG| cut -d'.' -f 4) #vedo se sono nella beta attraverso il tag
#BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5) #versione della beta da recuperare in caso che ci sia
read -p "Press enter to continue"
if [ ${BETA} != "beta" ] #ero fuori dalla beta
then
	if [ $1 = "y" ]
	then #sto entrando nella beta
		json -I -f package.json -e "this.beta= true"
		json -I -f package.json -e "this.betaCouter +=1"
	else
		if [ $1 = "n" ]
		then #sono gia fuori dalla beta allora devo solo incrementare la minor
			json -I -f package.json -e "this.versionC= this.versionC+1"
		fi
	fi
else #sono nella beta
	if[ ${BETA} != "beta" ] 
	then
		if [ $1 = "y" ]
		then #ci sono gia e voglio rimanerci 
			BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5)
			BETAVERSION=$((BETAVERSION+1)) #incremento la versione e gliela passo
			#json -I -f package.json -e "this.betaCouter = ${BETAVERSION}"
		else
			if [ $1 = "n" ]
			then #sto uscendo dalla beta
				json -I -f package.json -e "this.beta= false"
				json -I -f package.json -e "this.betaCouter =0"
			
			fi
		fi
	fi
fi



#VERSION=`git describe --tags --abbrev=0 | awk -F. '{OFS="."; $NF+=1	; print $0}'`
#git tag -a $VERSION -m "new release"+$VERSION

read -p "Press enter to continue"
#done
