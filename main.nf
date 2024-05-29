#!/usr/bin/env nextflow

params.file_int = 5

file_int = params.file_int

def helpMessage(message) {
    log.info"""
    ${message}

    Run multiple hashing algorithms on one of multiple files

    Usage:

    nextflow run jb-adams/md5-nf --file_int \${FILE_INT}

    Mandatory arguments:
      --file_int    [int] file to run. accepted values: [0, 1, 2, 3, 4]
    
    Optional arguments:
      --help        [flag] display this help message and exit

    """.stripIndent()
}

if (params.help) exit 0, helpMessage("")

if (file_int != 0 && file_int != 1 && file_int != 2 && file_int != 3 && file_int != 4 ) {
    exit 1, helpMessage("ERROR: missing or invalid value for --file_int")
}

file_path = "/data/${file_int}.json"

process md5 {

    output:
    stdout md5

    script:
    """
    echo "Running md5 on ${file_path}" >&2
    cat ${file_path} | cut -f 1 -d ' '
    """
}

md5.view {it.trim()}
