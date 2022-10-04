LAST_TAG=$(git describe) #sono nella cartella prova
echo ${LAST_TAG}
if [[ $LAST_TAG = *beta* ]]; then
	echo "siamo nella beta"
	BETAVERSION=$(echo $LAST_TAG| cut -d'.' -f 5)
	echo ${BETAVERSION}
	BETAVERSION=$((BETAVERSION+1))
	echo ${BETAVERSION}
fi

read -p "Press enter to continue"