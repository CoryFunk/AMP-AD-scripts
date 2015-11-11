# function: combine human ENCODE RNA-seq data into a table
# Transcript    Length  TPM     RPKM    KPKM    EstimatedNumKmers       EstimatedNumReads


# index transcripts
# create a list of genes from the first column of the snapr output
open FILE,"mouse_gene_list.txt" or die;
$i=0;
%iso2id=();
%id2iso=();
while ($line=<FILE>){
        chomp $line;
        @t=split '\t',$line;
        $iso2id{$t[0]}=$i;
        $id2iso{$i}=$t[0];
        $i++;
}
close FILE;
print "$i genes in found\n";
$niso=$i;


# main
# directory of all the files to be combined
@all=glob "/local/Cory/Alzheimers/cerebellum/*.txt";
$j=0;
%expr=();
%run2id=();
%id2run=();
foreach $file (@all){
        @t=split '/',$file;
        @t=split '\.',$t[-1];
        if (1==1){
                $run2id{$t[0]}=$j;
                $id2run{$j}=$t[0];



                # record gene counts 
                open FILE, "$file";
                while ($line=<FILE>){
                        chomp $line;
                        @tt=split '\t',$line;
                        $thisnread=$tt[1]; # number of reads
                        if (exists $iso2id{$tt[0]}){
                                $k=$iso2id{$tt[0]};
                                $expr[$k][$j]=$thisnread;
                        }
                }
                close FILE;



                $j++;
        }
}
print "$j runs found.\n";
$nrun=$j;

#############################
#############################
# write
print "writing to file...\n";
#this is the name of the output file
open NEW,"> results/AMP-AD_MayoRNAseq_UFL-Mayo-ISB_mRNA_Alzheimers_Disease_IlluminaHiSeq2000_CBE_geneExp_raw_count_Homo_sapiens" or die;
# print header
foreach $i (0..$nrun-2){
        print NEW "$id2run{$i}\t";
}
print NEW "$id2run{$nrun-1}\n";

#print RNA-seq data
foreach $i (0..$niso-1){
        $isoform=$id2iso{$i};
        print NEW "$isoform";
        foreach $j (0..$nrun-1){
                print NEW "\t$expr[$i][$j]";
        }
        print NEW "\n";
}

