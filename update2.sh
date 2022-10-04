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
read -p ${LAST_TAG}
res=${LAST_TAG//[^.]}
echo $res
echo ${#res}
BETA="foo"
if [ ${#res} != "2" ] #controllo se ho 2 o più punti per evitare di cercare il parametro beta
then
	#echo "sono dentro"
	BETA=$(echo $LAST_TAG| cut -d'.' -f 4) #vedo se sono nella beta attraverso il tag
	BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5) #versione della beta da recuperare in caso che ci sia
fi
read -p ${BETA}
read -p "la release che stai facendo è una beta(y/n)" response

#read -p $response
#read -p ${BETAVERSION}
if [ ${BETA} != "beta" ] #ero fuori dalla beta
then
	read -p "beta non c'e'"
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
			BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5)
			BETAVERSION=$((BETAVERSION+1)) #incremento la versione e gliela passo
			read -p ${BETAVERSION}
			json -I -f package.json -e "this.betaCouter = ${BETAVERSION}"
		else
			if [ $response = "n" ]
			then #sto uscendo dalla beta
				read -p "n"
				json -I -f package.json -e "this.beta=false"
				json -I -f package.json -e "this.betaCouter=0"
			
			fi
		fi
	fi
fi

VERSIONA=$(json -f package.json versionA)
VERSIONB=$(json -f package.json versionB)
VERSIONC=$(json -f package.json versionC)
dot="."
betaS="beta"
BETAFE=$(json -f package.json beta)
BETAV=$(json -f package.json betaCouter)
echo ${BETAFE}
if [ ${BETAFE} = "true" ]
then
	VERSION=$VERSIONA$dot$VERSIONB$dot$VERSIONC$dot$betaS$dot$BETAV
	git tag -a $VERSION -m "new release"
else
	VERSION=$VERSIONA$dot$VERSIONB$dot$VERSIONC
	git tag -a $VERSION -m "new release"
fi

read -p "Press enter to continue"
#done
