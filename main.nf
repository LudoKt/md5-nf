#!/usr/bin/env nextflow

params.file_int = 5
params.algorithm = 'invalid'

file_int = params.file_int
algorithm = params.algorithm

def helpMessage(message) {
    log.info"""
    ${message}

    Run selected hashing algorithm on one of multiple files

    Usage:

    nextflow run jb-adams/md5-nf --algorithm \${ALGORITHM} --file_int \${FILE_INT}

    Mandatory arguments:
      --algorithm   [string] hashing algorithm to run. accepted values: [md5, sha1, sha256]
      --file_int    [int] file to run. accepted values: [0, 1, 2, 3, 4]
    
    Optional arguments:
      --help        [flag] display this help message and exit

    """.stripIndent()
}

if (params.help) exit 0, helpMessage("")



if (file_int != 0 && file_int != 1 && file_int != 2 && file_int != 3 && file_int != 4 ) {
    exit 1, helpMessage("ERROR: missing or invalid value for --file_int")
}

if (algorithm != 'md5' && algorithm != 'sha1' && algorithm != 'sha256') {
    exit 1, helpMessage("ERROR: missing or invalid value for --algorithm")
}

file_path = "/data/${file_int}.json"

process checksum {

    output:
    stdout result

    script:
    if (algorithm == 'md5') {
        """
        md5sum ${file_path} | cut -f 1 -d ' '
        """
    }
    else if (algorithm == 'sha1') {
        """
        sha1sum ${file_path} | cut -f 1 -d ' '
        """
    } else if (algorithm == 'sha256') {
        """
        sha256sum ${file_path} | cut -f 1 -d ' '
        """
    }
}

result.view {it.trim()}
