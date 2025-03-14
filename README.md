# Nextflow_Map_ParallelRun
Index path issues hinder FastQ mapping, especially in Nextflow. We'll solve this, verifying paths pre-mapping, and making the path configurable. Parallel processing accelerates mapping, ensures reproducibility, and scales efficiently for multiple paired fastq..

Folder structure:
```
|____LICENSE
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


