while true
do
	string=`tail -1 nohup.out`
	if [ `echo $string | awk -v N=8 '{print $N}'` -eq '200' ]
	then 
		sh es_index.sh
		exit 0
	else
		continue
	fi
done
