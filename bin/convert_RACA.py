#!/opt/Python/2.7.3/bin/python
import sys
from collections import defaultdict
from numpy import *
import re
import os
import argparse

def usage():
    test="name"
    message='''
python convert_RACA.py --input rec_chrs.refined.txt
Convert RACA reference assist chromosome assembly results into JoinScaffold.txt and Split.txt, which can be used to create chromosome and gff annotation using superscafV3.pl.

Example input file:
1a_6a   0       185643  scaffold_618    0       185643  -
1a_6a   185643  185743  GAPS
1a_6a   185743  1020084 scaffold_47     0       834341  -
1a_6a   1020084 1020184 GAPS
1a_6a   1020184 1736266 scaffold_64     0       716082  -

Example JoinScaffold.txt
Chr	Super	Scaffold	Strand	Evidence
chr1	1	Scaffold000152	plus	rice/fpc
chr1	1	Scaffold000414	minus	fpc
chr1	1	Scaffold000138	plus	rice/fpc
chr1	1	Scaffold000057	minus	rice/fpc
chr1	1	Scaffold000119	plus	rice/fpc
chr1	1	Scaffold000013	minus	rice/fpc
chr1	1	Scaffold000061	minus	rice/fpc
chr1	1	Scaffold000052	minus	rice/fpc
chr1	1	Scaffold000021	plus	rice/fpc
chr1	1	Scaffold000081	plus	rice/fpc
chr1	1	Scaffold000302	minus	fpc
chr1	2	Scaffold000136	plus	rice/fpc
chr1	2	Scaffold000046	minus	rice/fpc
chr1	2	Scaffold000032	plus	rice/fpc


Example Split.txt
Scaffold000002	274002
Scaffold000005	314038
Scaffold000009	3370407
Scaffold000038	925888
Scaffold000072	79600
Scaffold000077	401265
Scaffold000111	474300
Scaffold000204	168000
Scaffold000128	333521
    '''
    print message

def convert(raca):
    s = re.compile(r'scaffold')
    with open (raca, 'r') as infile:
        for line in infile:
            line = line.rstrip()
            unit = re.split(r'\t', line)
            if (s.search(unit[3])):
                print line
                
                

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input')
    parser.add_argument('-o', '--output')
    parser.add_argument('-v', dest='verbose', action='store_true')
    args = parser.parse_args()
    try:
        len(args.input) > 0
    except:
        usage()
        sys.exit(2)

    convert(args.input)

if __name__ == '__main__':
    main()

