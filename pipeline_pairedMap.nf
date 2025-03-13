params.input_csv = "paired_sample.csv"

// Create a channel from the CSV
Channel.fromPath(params.input_csv)
    .splitCsv(header: true)
    .map { row -> 
        tuple(row.sample_id, file(row.fastq_1), file(row.fastq_2))
    }
    .set { samples_ch }

// Check the channel content
samples.view { pair ->
    println("Sample ID: ${pair[0]}, Read1: ${pair[1]}, Read2: ${pair[2]}")
}

// Example process that would use these inputs
process FASTQC {
    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "*_fastqc.*"

    script:
    """
    fastqc ${read1} ${read2}
    """
}

workflow {
    samples | FASTQC
}
