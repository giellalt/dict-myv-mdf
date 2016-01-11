
# Dette skal bli ei makefil for å lage myvmdf.fst, 
# ei fst-fil som tar fkv og gjev ei nob-omsetjing.

# Førebels er det berre eit shellscript.
# Kommando for å lage myvmdf.fst

# @cip: makefilen er allerede for lengst ferdig,
# dette skriptet kan slettes.
# ../make-bildict
# kommando:
# make -f make-bildict SLANG=swe TLANG=sma TNUM=all

# sh myvmdf.sh

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/myvmdf.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/myvmdf.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/myvmdf.lexc
cat src/*_myvmdf.xml | \
grep '^ *<[lt][ >]'  | \
tr ':' '='           | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr '[ ]' '_'           | \
sed 's/$/ # ;/g;'    >> bin/myvmdf.lexc        

#xfst -e "read lexc < bin/myvmdf.lexc"

printf "read lexc < bin/myvmdf.lexc \n\
invert net \n\
save stack bin/myvmdf.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile



