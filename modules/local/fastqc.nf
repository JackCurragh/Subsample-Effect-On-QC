

process FASTQC {

	publishDir "${params.output_dir}/fastqc", mode: 'copy'
	
    container = 'docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0'
	
    input:
	    file fastq 

	output:
	    path "*_fastqc.zip", emit: fastqc_zip

    script:
        """
        fastqc -q $fastq 
        """
}