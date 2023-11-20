#!/usr/bin/env nextflow

/// Specify to use Nextflow DSL version 2
nextflow.enable.dsl=2

/// Import modules and subworkflows
include { quality_control } from './subworkflows/local/quality_control.nf'

// Log the parameters
log.info """\

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||                        INSERT PIPELINE NAME                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Parameters                                                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  input_dir   : ${params.input_dir}                                     
||  outDir      : ${params.output_dir}                                        
||  workDir     : ${workflow.workDir}                                     
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

"""
// Help Message to prompt users to specify required parameters
def help() {
    log.info"""
  Usage:  nextflow run main.nf --input <path_to_fastq_dir> 

  Required Arguments:

  --input    Path to directory containing fastq files.

  Optional Arguments:

  --outDir	Path to output directory. 
	
""".stripIndent()
}
params.percent_values = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

/// Define the main workflow
workflow {
    /// Define the input channels
    fastq_ch        = Channel.fromPath("${params.input_dir}/*.fastq.gz")
                        .ifEmpty { exit 1, "No fastq files found in ${params.input_dir}" }

    percents        = Channel.of(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9)
    combined_ch     = fastq_ch.combine(percents) 

    quality_control(combined_ch)
    }

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
