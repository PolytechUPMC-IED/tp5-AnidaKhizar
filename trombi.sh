#!/bin/bash

tar xzvf $1 #on decompresse l'archive passée en paramètres

FICHIERS_JPG=`ls *.jpg` #on fait la liste des images dans notre fichier

for i in $FICHIERS_JPG;
do
#pour chaque image on récupère le prenom, le nom la spécialité et l'annee
    prenom=`cut -d"_" -f1 <<< $i`
    nom=`cut -d"_" -f2 <<< $i`
    spe=`cut -d"_" -f3 <<< $i`
    annee=`cut -d"_" -f4 <<< $i`

    mkdir -p  "$spe${annee%.*}" 
    convert -resize 90x120 $i "$nom.$prenom.jpg"
    mv "$nom.$prenom.jpg" "$spe${annee%.*}"

#on ajoute le nom de la spécialité dans un fichier temporaire
    echo "$spe${annee%.*}" >> tmp.txt
done

#on supprime tous les doublons qui se trouvent dans notre fichier temporaire pour avoir la liste des specialites dans filieres.txt
cat tmp.txt | sort | uniq > filieres.txt

while read SPE;
do

#on se rend dans le dossier SPE et on crée l'en-tete du fichier html
    cd "$SPE"
    echo "<html><head><title> Trombinoscope $SPE</title></head>
<body>
<h1 align=’center’>Trombinoscope $SPE</h1>
<table cols=2 align=’center’>" > ${SPE}.html

#on remplit le corps du fichier html
    IMAGE=`ls *.jpg`
    for i in $IMAGE;
    do
        nom=`cut -d"." -f1 <<< $i`
		prenom=`cut -d"." -f2 <<< $i`
		echo "<tr>
<td><img src="$i" width=90 height=120/><br/>$prenom $nom</td>
</tr>" >> ${SPE}.html
   	 done

#on écrit la fin du fichier html
   	 echo "</table>
</body></html>" >> ${SPE}.html

   	 cd ..
    
done<filieres.txt

rm filieres.txt
rm tmp.txt
