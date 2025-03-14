#!/usr/bin/env nextflow

params.fastq = "/Users/dhusiakalyani/MapMulti/Nextflow_Map_ParallelRun/fastq/"

// Setting up the channel to pair FASTQ files
fastq_ch = Channel.fromFilePairs("${params.fastq}*_{read1,read2}.fastq.gz", size: 2, flat: true)

// Printing out each pair to verify correct pairing
fastq_ch.view { pair -> 
    println("Sample ID: ${pair[0]}, Read1: ${pair[1]}, Read2: ${pair[2]}")
}
