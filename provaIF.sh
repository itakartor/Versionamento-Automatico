VERSIONA=$(json -f package.json versionA)
VERSIONB=$(json -f package.json versionB)
VERSIONC=$(json -f package.json versionC)
dot="."
beta="beta"
BETA=$(json -f package.json beta)
BETAV=$(json -f package.json betaCouter)
echo ${BETA}
if [ ${BETA} = "true" ]
then
	VERSION=$VERSIONA$dot$VERSIONB$dot$VERSIONC$dot$beta$dot$BETAV
	git tag -a $VERSION -m "new release"+$VERSION
else
	VERSION=$VERSIONA$dot$VERSIONB$dot$VERSIONC
	git tag -a $VERSION -m "new release"+$VERSION
fi
read -p "Press enter to continue"
#VERSION=
#git tag -a $VERSION -m "new release"+$VERSION