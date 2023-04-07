process SAMPLESHEET_CHECK {
    tag "$samplesheet"
    label 'process_single'


    conda "enironment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.8.3' :
        'quay.io/biocontainers/python:3.8.3' }"

    input:
    path samplesheet

    output:
    path '*.csv'       , emit: csv

    when:
    task.ext.when == null || task.ext.when

    script: // This script is bundled with the pipeline, in kenibrewer/simplenextflow/bin/
    """
    check_samplesheet.py \\
        $samplesheet \\
        samplesheet.valid.csv
    """
}
