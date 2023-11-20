process MULTIQC {

    container = 'docker://quay.io/biocontainers/multiqc:1.18--pyhdfd78af_0'

    publishDir "${params.output_dir}/multiqc", mode: 'copy'

	input:
	    path inputs

	output:
	    path "*.html", emit: report_html
        path "multiqc_data", emit: report_data

    script:
        """
        multiqc . 2> /dev/null
        """
}