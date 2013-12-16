#sed 's/1a_6a/6/' ../input/RACA_PE2/rec_chrs.refined.txt | sed 's/4a/4/' | sed 's/4b/4/' | sed 's/6b/6/' | sed 's/^1b/1/' | sed 's/11a/11/' | sed 's/11b/11/' | cat > ../input/RACA_PE2/rec_chrs.refined_manual.txt

awk '{if($1==5){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr5.txt
awk '{if($1==7){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr7.txt
awk '{if($1==8){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr8.txt
awk '{if($1==6){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr6a.txt
awk '{if($1==4){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr4a.txt

python ReOrder.py --input chr5.txt
python ReOrder.py --input chr7.txt
python ReOrder.py --input chr8.txt
python ReOrder.py --input chr4a.txt
python ReOrder.py --input chr6a.txt

awk '{if($1==1){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr1.txt
awk '{if($1==2){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr2.txt
awk '{if($1==3){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr3.txt
awk '{if($1==4){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr4.txt
awk '{if($1==6){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr6.txt
awk '{if($1==9){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr9.txt
awk '{if($1==10){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr10.txt
awk '{if($1==11){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr11.txt
awk '{if($1==12){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr12.txt

cat chr1.txt chr2.txt chr3.txt chr4a.txt.reorder chr4.txt chr5.txt.reorder chr6a.txt.reorder chr6.txt chr7.txt.reorder chr8.txt.reorder chr9.txt chr10.txt chr11.txt chr12.txt > ../input/RACA_PE2/rec_chrs.refined_manual.final.txt

if [ 1 -eq 0 ]; then


awk '{if($1==3){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr3.txt
awk '{if($1==5){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr5.txt
awk '{if($1==7){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr7.txt
awk '{if($1==9){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr9.txt
awk '{if($1==10){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr10.txt
awk '{if($1==6){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr6.txt
awk '{if($1==4){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr4b.txt
awk '{if($1==1){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr1a.txt
awk '{if($1==1){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr1b.txt
python ReOrder.py --input chr3.txt
python ReOrder.py --input chr5.txt
python ReOrder.py --input chr6.txt
python ReOrder.py --input chr7.txt
python ReOrder.py --input chr9.txt
python ReOrder.py --input chr10.txt
python ReOrder.py --input chr4b.txt
python ReOrder.py --input chr1a.txt
python ReOrder.py --input chr1b.txt

awk '{if($1==2){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr2.txt
awk '{if($1==8){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr8.txt
awk '{if($1==11){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr11.txt
awk '{if($1==12){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr12.txt
awk '{if($1==6){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr6a.txt
awk '{if($1==4){print}}' ../input/RACA_PE2/rec_chrs.refined_manual.txt > chr4.txt

cat chr1a.txt.reorder chr1b.txt.reorder chr2.txt chr3.txt.reorder chr4.txt chr4b.txt.reorder chr5.txt.reorder chr6a.txt chr6.txt.reorder chr7.txt.reorder chr8.txt chr9.txt.reorder chr10.txt.reorder chr11.txt chr12.txt > ../input/RACA_PE2/rec_chrs.refined_manual.final.txt

fi

