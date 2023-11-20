

// Include the necessary modules for this workflow
include { FASTQC } from '../../modules/local/fastqc.nf'
include { SUBSAMPLE } from '../../modules/local/subsample.nf'
include { MULTIQC } from '../../modules/local/multiqc.nf'




workflow quality_control {
    take:
        fastq

    main:
        subsample_ch =      SUBSAMPLE(fastq)
        fastqc_ch    =      FASTQC(subsample_ch)
        all_fastqc   =      fastqc_ch.collect()
        multiqc_ch   =      MULTIQC(all_fastqc)
}