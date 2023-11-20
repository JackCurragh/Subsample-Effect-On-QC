process SUBSAMPLE {

    container = 'docker://quay.io/biocontainers/seqtk:1.4--he4a0461_1'

	input:
	    tuple file(fastq), val(percent)

	output:
	    path "*percent.fastq", emit: subsampled

    script:
        """
        seqtk sample ${fastq} ${percent} > ${fastq.simpleName}_${percent}_percent.fastq
        """
}