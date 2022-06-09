fi=(LISTOFFILES)

echo "${#fi[@]}"

for sigm in {SIGMAMIN..SIGMAMAX..SIGMAGAP}
do
    for m in {MASSMIN..MASSMAX..GAPS}
    do
	VAR1=""
	VAR2="sigma="${sigm}","${sigm}":"
	VAR3="sigma="${sigm}","${sigm}":"
	VAR4="sigma="${sigm}","${sigm}":"
	VAR5=""
	VAR6=""
	for f in "${fi[@]}"
	do
	    #combine -M Significance test_${f}.root -m 2500 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_${f}=1,1 --pvalue
	    #combine -M Significance test_${f}.root -m 2800 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_${f}=1,1
	    #combine -M MultiDimFit test_${f}.root -m 2500 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_${f}=1,1
	    for v in 0 -1 1 -10 10
	    do
		#echo ${f}
		#echo ${v}
		#echo combine -M MultiDimFit test_${f}.root -m 2500 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_${f}=1,1 --setParameters p1_${f}=${v}
		#combine -M MultiDimFit test_${f}.root -m 2500 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_${f}=1,1 --setParameters p1_${f}=${v}
		NCLIENTS_RUNNING=$(combine -M MultiDimFit test_${f}.root -m ${m} --rMax 1000 --setParameterRanges sigma=${sigm},${sigm}:sig_rate_${f}=1,1 --setParameters p1_${f}=${v} | grep WARNING: | wc | awk {'print $1'})
		if [ ${NCLIENTS_RUNNING} -lt 1 ]
		then
		    combine -M MultiDimFit test_${f}.root -m ${m} --rMax 1000 --setParameterRanges sigma=${sigm},${sigm}:sig_rate_${f}=1,1 --setParameters p1_${f}=${v} | grep 'r : '
		    combine -M Significance test_${f}.root -m ${m} --rMax 1000 --setParameterRanges sigma=${sigm},${sigm}:sig_rate_${f}=1,1 --setParameters p1_${f}=${v} | grep 'Significance: '
		    VAR1+="p1_${f}=${v},"
		    VAR2+="sig_rate_${f}=0.0001,0.0001:"
		    VAR3+="sig_rate_${f}=0.0001,0.0001:"
		    VAR4+="sig_rate_${f}=0,1000:"
		    #VAR5+="-P sig_rate_${f} "
		    VAR5+="-P sig_rate_${f} -P bkg_rate_${f} -P p1_${f} -P p2_${f} -P p3_${f} "
		    VAR6+="bkg_rate_${f},p1_${f},p2_${f},p3_${f},"
		    break
		fi
	    done
	done
	
	
	#NCLIENTS_RUNNING=$(combine -M MultiDimFit test_bkgL_210_255_sigL_259_289.root -m 2500 --rMax 1000 --setParameterRanges sigma=75,75:sig_rate_bkgL_210_255_sigL_259_289=1,1 --setParameters p1_bkgL_210_255_sigL_259_289=-10 -v 10 | grep WARNING | wc | awk {'print $1'})
	
	echo ${VAR1}
	echo " "
	echo ${VAR2}
	echo " "
	echo ${VAR3}
	echo " "
	echo ${VAR4}
	echo " "
	echo ${VAR5}
	echo " "
	echo ${VAR6}
	echo " "
	
	##combine -M ChannelCompatibilityCheck fullCard.root -m 2500 --preFitValue 0 --rMax 1000 --setParameterRanges ${VAR2%?} --saveFitResult --saveNLL --fixedSignalStrength 0 --setParameters ${VAR1%?}
	#
	#combine -M MultiDimFit fullCard.root -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR2%?} --setParameters ${VAR1%?} -v 10 -n blahblah --keepFailures --saveWorkspace &> initialFit.txt
	#
	#combine higgsCombineblahblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR3%?} -v 10 -n blah &> noSigFit.txt
	#
	#combine higgsCombineblahblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 0 --rMin 0 --setParameterRanges ${VAR4%?} ${VAR5} -v 10 -n noblah &> SigFit.txt
	
	combine -M MultiDimFit fullCard.root -m ${m} --rMax 1 --rMin 1 --setParameterRanges ${VAR2%?} --setParameters ${VAR1%?} -v 10 -n NoSig --keepFailures --saveWorkspace --saveNLL &> initialFit${m}_${sigm}.txt
	mv higgsCombineNoSig.MultiDimFit.mH${m}.root higgsCombineNoSig.MultiDimFit.mH${m}_sigma${sigm}.root
	#combine higgsCombineblahblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR3%?} --floatParameters ${VAR6%?} -v 10 -n blah --saveNLL &> noSigFit.txt
	
	#combine higgsCombineblahblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR4%?} ${VAR5} --floatParameters ${VAR6%?} -v 10 -n noblah &> SigFit.txt
	#combine higgsCombineblahblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR4%?} ${VAR5} --setParameters ${VAR1%?} -v 10 -n noblah &> SigFit.txt
	combine -M MultiDimFit fullCard.root -m ${m} --rMax 1 --rMin 1 --setParameterRanges ${VAR4%?} ${VAR5} --setParameters ${VAR1%?} -v 10 -n Sig --keepFailures --saveWorkspace --saveNLL &> SigFitInit${m}_${sigm}.txt
	mv higgsCombineSig.MultiDimFit.mH${m}.root higgsCombineSig.MultiDimFit.mH${m}_sigma${sigm}.root
	#combine higgsCombinenoblah.MultiDimFit.mH${m}.root --snapshotName MultiDimFit -M Significance -m ${m} --rMin 1 --rMax 1 -v 10 &> checksig${m}.txt
	#combine higgsCombinenoblah.MultiDimFit.mH2500.root --snapshotName MultiDimFit -M MultiDimFit -m 2500 --rMax 1 --rMin 1 --setParameterRanges ${VAR4%?} ${VAR5} -v 10 -n allsig --saveNLL &> SigFit.txt
	
    done
done
