#!/bin/bash
#$ -N reza_jobs
#$ -q rg-el6
#$ -l virtual_free=10G,h_rt=8:00:00
#$ -m abe 
#$ -M reza.sodaei@crg.es
#$ -j y
#$ -o /dev/null
#$ -e /dev/null
cd ~/vast-tools/vast_out/
#Make the var huma-redable
lineNumber=3500
count=0
sed -n "$lineNumber"',$p' /users/rg/rsodaei/vast_GTEx/index_for_master.txt| 
while IFS=\t read line && [ "$count" -le 2500 ]
do 
	s=$(echo $line | cut -f1 -d' ')
	#s1=$(echo $s | cut -f11 -d'/')
	#s2=$(echo $s1 | cut -f1 -d.)
	#	s3=$(echo $s2 | cut -f2 -d'=')
	echo $s 
	#echo $s1
	#echo $s2
	#echo $tt
	awk '$6=="S" && $4 > 52  || $6=="C1" && $4 > 52 || $6=="C2" && $4 > 52 || $6=="C3" && $4 > 52 {print $1"\t"$2"\t"$3"\t"$4"\t"$7"\t"$8}' $s/INCLUSION_LEVELS_FULL-Hsa1.tab  | awk '{print $6}' | cut -d, -f1 | awk  -v var="$s" 'BEGIN {print 'var'} {print $0}' > ~/quality
	#echo 'PSI was created'
#	tt=${tt%/}
#	result=${tt##*/}
#	var1=$(echo $result | cut -f1,2,3 -d.)
#	#cd /users/rg/rsodaei/Cufflinkgeuvadis/users/rg/projects/Geuvadis/mapping/xs/$var1
#	var2=$(echo $var1 | cut -f1,2,3 -d.)
#	echo $var2
#	awk  -v var="$tt" 'BEGIN {print 'var'}
#	          {print $1}' PSI > var2.txt
#	#awk -F'\t' -v OFS='\t' 'NR==FNR{a[$1FS$1]=$1;next}$1FS$1 in a{print $0,a[$1FS$1]}' /users/rg/rsodaei/Cufflinkgeuvadis/users/rg/projects/Geuvadis/mapping/xs/corrcet $var2.txt > hmm$var2.txt
	paste -d "\t" /users/rg/rsodaei/vast_GTEx/ID2.txt ~/quality > ~/temp2
	#echo 'PSI was attached to Micro_S_ID'
	mv ~/temp2 /users/rg/rsodaei/vast_GTEx/ID2.txt
	#echo 'the big file was updated'
	count=$(($count+1))
#	#awk -F'\t' -v OFS='\t' 'NR==FNR{a[$1]=$1;next}$2FS$3 in a{print $0,a[$2FS$3]}'
#		#mv $tt /users/rg/rsodaei/Cufflinkgeuvadis/users/rg/projects/Geuvadis/mapping/xs/$var1
#
#	#cd /users/rg/rsodaei/Cufflinkgeuvadis/users/rg/projects/Geuvadis/mapping/xs/$var1
#
#	#perl ~/adding_col.pl $var1 transcripts.gtf > temp && mv temp transcripts.gtf
	
done
