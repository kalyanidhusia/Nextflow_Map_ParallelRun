#!/usr/bin/env nextflow

// Module INCLUDE statements
include { FASTQC } from './module/fastqc.nf'
include { TRIM_GALORE } from './module/trim_galore.nf'
include { HISAT2_ALIGN } from './module/hisat2_align.nf'
include { MULTIQC } from './module/multiqc.nf'

/*
 * Pipeline parameters
 */
params.hisat2_index_zip = "./genome_index.tar.gz"
params.report_id = "all_paired-end"

// Primary input
params.input_csv = "./paired_sample.csv"

workflow {

    read_ch = Channel.fromPath(params.input_csv)
                .splitCsv(header:true)
                .map { row -> tuple(file(row.fastq_1), file(row.fastq_2)) }

    // Debug print of input files
    read_ch.view { files -> println("FASTQ Pair: ${files[0]}, ${files[1]}") }

    // FASTQC receives pairs, might run on both files individually
    FASTQC(read_ch)

    // Ensure TRIM_GALORE also receives pairs explicitly
    TRIM_GALORE(read_ch)

    trimmed_reads_ch = TRIM_GALORE.out.trimmed_reads

    trimmed_reads_ch.view { trimmed -> println("Trimmed reads: ${trimmed}") }

    // Alignment to a reference genome
    HISAT2_ALIGN(TRIM_GALORE.out.trimmed_reads, file (params.hisat2_index_zip))

    // Comprehensive QC report generation
    MULTIQC(
        FASTQC.out.zip.mix(
        FASTQC.out.html,
        TRIM_GALORE.out.trimming_reports,
        TRIM_GALORE.out.fastqc_reports_1,
        TRIM_GALORE.out.fastqc_reports_2,
        HISAT2_ALIGN.out.log
        ).collect(),
        params.report_id
    )
}