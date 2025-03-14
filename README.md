# Nextflow_Map_ParallelRun
Index path issues hinder FastQ mapping, especially in Nextflow. We'll solve this, verifying paths pre-mapping, and making the path configurable. Parallel processing accelerates mapping, ensures reproducibility, and scales efficiently for multiple paired fastq..

Current Workflow Structure
```
Nextflow_Map_ParallelRun
|____module
| |____multiqc.nf
| |____fastqc.nf
| |____hisat2_align.nf
| |____trim_galore.nf
|____fastq_reads.nf
|____paired_sample.csv
|____pipeline_pairedMap.nf
|____genome_index.tar.gz
|____fastq
| |____HBR_Rep2_ERCC_read1.fastq.gz
| |____UHR_Rep3_ERCC_read1.fastq.gz
| |____UHR_Rep2_ERCC_read1.fastq.gz
| |____HBR_Rep3_ERCC_read1.fastq.gz
| |____ ...
|____fastQC
| |____HBR_Rep3_ERCC_read1_fastqc.zip
| |____UHR_Rep1_ERCC_read2_fastqc.zip
| |____HBR_Rep1_ERCC_read2_fastqc.html
| |____HBR_Rep1_ERCC_read1_fastqc.zip
| |____ ...
```
Running the Workflow

`nextflow run pipeline_pairedMap.nf`

DAG Visualization

To visualize the workflow DAG, run:

`nextflow run pipeline_pairedMap.nf -with-dag pipeline_dag.png`
```
nextflow run pipeline_pairedMap.nf -with-dag pipeline_dag.dot && \
dot -Tpng \
  -Gbgcolor=white \
  -Ncolor="#2c7fb8" \
  -Nfontcolor="#253494" \
  -Nstyle="filled,bold" \
  -Nfillcolor="#edf8b1" \
  -Ecolor="#41b6c4" \
  pipeline_dag.dot -o pipeline_dag_colored.png
```

Tasks Completed:

-Genome Indexing with BWA:

Created a Nextflow process to index reference genomes using BWA.
Ensured output index files (.bwt, .ann, .pac, .sa) are correctly placed in the desired directory (index_dir) using the publishDir directive.
Added debug statements to verify file paths and process execution.

-Paired-End RNAseq Workflow:

Adapted the existing single-end RNAseq Nextflow pipeline (rnaseq.nf) to handle paired-end data, modifying input and output channels accordingly.
Clearly managed channel definitions to handle paired FASTQ files.

-Error Handling and Debugging:

Addressed issues with processes failing silently by incorporating print statements and debugging via Nextflow's .command.sh and .command.log.
Identified a critical missing dependency error (trim_galore, exit status 127).
Decided to temporarily remove the problematic TRIM_GALORE step from the pipeline until a suitable environment setup is available.
Trim_galore is not implemented back on!

-Finalized Stable Pipeline:

Produced a simplified but stable RNAseq Nextflow workflow, ensuring reliable execution and accurate file placement for subsequent analysis.
