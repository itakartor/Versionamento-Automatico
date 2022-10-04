LAST_TAG=$(git describe) #ultimo tag di git
#BETA=$(json -f package.json beta) #prendo il valore di beta dal package
read -p ${LAST_TAG}
BETA=$(echo $LAST_TAG| cut -d'.' -f 4) #vedo se sono nella beta attraverso il tag
BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5) #versione della beta da recuperare in caso che ci sia
read -p ${BETA}
read -p $1
read -p ${BETAVERSION}
if [ $BETA != "beta" ]  #ero fuori dalla beta
then
	echo "non sono in beta"
else
	echo "sono in beta"
fi
read -p "Press enter to continue"