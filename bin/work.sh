echo "after sed, edit the RACA results to get a correct chromosome order, use excel to reverse the scaffold order when neccesery"
sed 's/1a_6a/6/' rec_chrs.refined.txt | sed 's/4a/4/' | sed 's/4b/4/' | sed 's/6b/6/' | sed 's/1b/1/' | cat > rec_chrs.refined_manual.txt
echo "convert RACA into Join and Split table"
python convert_RACA.py --input ../input/rec_chrs.refined_manual.txt --fasta ../input/HEG4.fa
echo "create chromosome"
perl superscafV3.pl --fasta ../input/HEG4.fa --link Prefix.JoinScaffold.txt --cut Prefix.Split.txt --project HEG4.RACA > log 2> log2 &


echo "reorder"
awk '{if($1==3){print}}' ../input/rec_chrs.refined_manual.txt > chr3.txt
awk '{if($1==5){print}}' ../input/rec_chrs.refined_manual.txt > chr5.txt
awk '{if($1==7){print}}' ../input/rec_chrs.refined_manual.txt > chr7.txt
awk '{if($1==9){print}}' ../input/rec_chrs.refined_manual.txt > chr9.txt
awk '{if($1==10){print}}' ../input/rec_chrs.refined_manual.txt > chr10.txt
awk '{if($1==6){print}}' ../input/rec_chrs.refined_manual.txt > chr6.txt
awk '{if($1==4){print}}' ../input/rec_chrs.refined_manual.txt > chr4b.txt
awk '{if($1==1){print}}' ../input/rec_chrs.refined_manual.txt > chr1a.txt
awk '{if($1==1){print}}' ../input/rec_chrs.refined_manual.txt > chr1b.txt
python ReOrder.py --input chr3.txt
python ReOrder.py --input chr5.txt
python ReOrder.py --input chr6.txt
python ReOrder.py --input chr7.txt
python ReOrder.py --input chr9.txt
python ReOrder.py --input chr10.txt
python ReOrder.py --input chr4b.txt
python ReOrder.py --input chr1a.txt
python ReOrder.py --input chr1b.txt

awk '{if($1==2){print}}' ../input/rec_chrs.refined_manual.txt > chr2.txt
awk '{if($1==8){print}}' ../input/rec_chrs.refined_manual.txt > chr8.txt
awk '{if($1==11){print}}' ../input/rec_chrs.refined_manual.txt > chr11.txt
awk '{if($1==12){print}}' ../input/rec_chrs.refined_manual.txt > chr12.txt
awk '{if($1==6){print}}' ../input/rec_chrs.refined_manual.txt > chr6a.txt
awk '{if($1==4){print}}' ../input/rec_chrs.refined_manual.txt > chr4.txt

cat chr1a.txt.reorder chr1b.txt.reorder chr2.txt chr3.txt.reorder chr4.txt chr4b.txt.reorder chr5.txt.reorder chr6a.txt chr6.txt.reorder chr7.txt.reorder chr8.txt chr9.txt.reorder chr10.txt.reorder chr11.txt chr12.txt > ../input/rec_chrs.refined_manual.final.txt

echo "convert RACA into Join and Split table"
python convert_RACA.py --input ../input/rec_chrs.refined_manual.final.txt --fasta ../input/HEG4.fa --output HEG4
echo "create chromosome"
perl superscafV3.pl --fasta ../input/HEG4.fa --link HEG4.JoinScaffold.txt --cut HEG4.Split.txt --project HEG4.RACA > log 2> log2 &
echo "create chromosome with annotation"
perl superscafV3.pl --fasta ../input/HEG4.fa --link HEG4.JoinScaffold.txt --cut HEG4.Split.txt --gff /rhome/cjinfeng/BigData/01.Rice_genomes/HEG4/00.Annotation/HEG4_allpathlgv1.maker.gff3 --project HEG4.RACA > log 2> log2 &
echo "code gene "
perl AssignGeneCode4chr.pl --gff HEG4.RACA.chr.gff --anno /rhome/cjinfeng/BigData/00.RD/Annotation/Function_annotaion/TIGR7/bin/HEG4_allpathlgv1.maker.proteins.fasta.anno
perl AssignGeneCode4scaffold.pl --gff HEG4.RACA.scaffold.gff --code HEG4.RACA.chr.v1.code --anno /rhome/cjinfeng/BigData/00.RD/Annotation/Function_annotaion/TIGR7/bin/HEG4_allpathlgv1.maker.proteins.fasta.anno


echo "RACA_PE2"
python convert_RACA.py --input ../input/RACA_PE2/rec_chrs.refined_manual.final.txt --fasta ../input/HEG4.fa --output HEG4
perl superscafV3.pl --fasta ../input/HEG4.fa --link HEG4.JoinScaffold.txt --cut HEG4.Split.txt --project HEG4.RACA > log 2> log2 &

