#!/bin/sh


##Functia medie-> deschide fisierul csv dat de utilizator si calculeaza media notelor fiecarui student
function medie() {
    printf "\n"
    read -p "Introduceti numele fisierului:" filename
    gedit $filename
    awk -F "\"*,\"*" '{printf " Media studentului: %s %s este %s\n ", $1, $2, ($3+$4+$5+$6)/4 }' $filename 
    ok=true  ##daca functia a rulat cu succes
                                 }

## Functia salvare_medie salveaza mediile calculate la punctul 1.			 
function salvare_medie() {
    printf "\n"
    printf " "		
    if [ $ok == true ]; 
    then 
        read -p "Introduceti numele fisierului in care doriti salvarea mediilor :" numefisier
        awk -F "\"*,\"*" '{printf " Media studentului: %s %s este %s\n ", $1, $2, ($3+$4+$5+$6)/4 }' $filename > $numefisier
        gedit $numefisier
	echo "mediile au fost salvate in fisier"
        ok1=true
    else	 
        echo " Eroare. Nu puteti rula punctul 2 pana nu rulati punctul 1." 
    fi	  
}

 ## Functia arhivare arhiveaza fisierele de la punctele 1 si 2.
			   
function arhivare() {
    printf "\n"
    if [[  $ok == true && $ok1 == true ]];
    then
        tar -czvf arhivamedii.tar.gz  $filename  $numefisier
        else echo " Eroare. Nu puteti rula punctul 3 pana nu rulati punctele 1 si 2."
    fi    
}

## Functia procese afiseaza numarul de procese pornite de un utilizator introdus de la tastatura 

function procese() {
    printf "\n"
    read -p "Introduceti numele utilizatorului:" username
    ps -u $username
}


## Functia meniu afiseaza optiunile disponibile utilizatorului 

function meniu() {
    printf "\n"
                
    echo "========================================="
    echo "             --- Meniu ---"
    echo "========================================="
    echo "1.Calculul mediilor studentilor"
    echo "2.Salvarea mediilor intr-un fisier separat"
    echo "3.Arhivare tar"
    echo "4.Afisare procese pornite"
    echo "q.Iesire"
    echo  "Introduceti optiunea dorita:" 

    read -n 1 option  
    case $option in 
		
        1) medie ; meniu;;
        2) salvare_medie ; meniu;;
        3) arhivare ; meniu;;
        4) procese ; meniu;;
        q) exit ;;
	
		
    esac  
}
    ok=false

    meniu



