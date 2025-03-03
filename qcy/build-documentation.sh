#!/bin/bash

ROOT=./data/schemas/
VERSION=v0.0.1
INPUT_DIR=${ROOT}${VERSION}/
OUTPUT_FILE=${ROOT}qcy-${VERSION}.ttl
DOC_DIR=${ROOT}DOCS/qcy-${VERSION}
WIDOCO_PATH=./tools/widoco_v1.4.25.jar

CURRENT_DATETIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo BUILDING QAECY ONTOLOGY...

# WRITE METADATA WITH UPDATED MODIFIED DATE
perl -pe "s/dcterms:modified\s+\"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\"/dcterms:modified \"${CURRENT_DATETIME}\"/g" ${INPUT_DIR}_metadata.ttl > ${OUTPUT_FILE}
echo Updated ontology modification datetime to: ${CURRENT_DATETIME}

#CONCATENATE ONTOLOGIES
echo Combining ttl-files from: ${INPUT_DIR}
find ${INPUT_DIR} -type f -name '*.ttl' ! -name '_*.ttl' -exec cat {} + >> ${OUTPUT_FILE}
echo Built ontology: ${OUTPUT_FILE}

# BUILD DOCUMENTATION
# Options are found [here](https://github.com/dgarijo/Widoco/?tab=readme-ov-file#execution-options)
java -jar $WIDOCO_PATH -ontFile $OUTPUT_FILE -outFolder $DOC_DIR -webVowl -oops -noPlaceHolderText -rewriteAll
echo Built ontology documentation: ${DOC_DIR}

echo QAECY ONTOLOGY READY

echo BUILDING ENUMERATIONS...
ENUM_DIR=${ROOT}enums/
ENUM_FILE=${ROOT}qcy-e.ttl
ENUM_DOC_DIR=${ROOT}DOCS/qcy-e

# WRITE METADATA WITH UPDATED MODIFIED DATE
perl -pe "s/dcterms:modified\s+\"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\"/dcterms:modified \"${CURRENT_DATETIME}\"/g" ${ENUM_DIR}_metadata.ttl > ${ENUM_FILE}
echo Updated enums modification datetime to: ${CURRENT_DATETIME}

#CONCATENATE ENUMS
echo Combining ttl-files from: ${ENUM_DIR}
find ${ENUM_DIR} -type f -name '*.ttl' ! -name '_*.ttl' -exec cat {} + >> ${ENUM_FILE}
echo Built enumerations: ${ENUM_FILE}

java -jar $WIDOCO_PATH -ontFile $ENUM_FILE -outFolder $ENUM_DOC_DIR -noPlaceHolderText -rewriteAll
echo Built enumerations documentation: ${ENUM_DOC_DIR}

echo ENUMERATIONS READY

echo BUILDING SHAPES...
SHAPE_DIR=${ROOT}shapes/
SHAPE_FILE=${ROOT}shapes.ttl
SHAPE_DOC_DIR=${ROOT}DOCS/shapes

# WRITE METADATA WITH UPDATED MODIFIED DATE
perl -pe "s/dcterms:modified\s+\"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\"/dcterms:modified \"${CURRENT_DATETIME}\"/g" ${SHAPE_DIR}_metadata.ttl > ${SHAPE_FILE}
echo Updated enums modification datetime to: ${CURRENT_DATETIME}

#CONCATENATE ENUMS
echo Combining ttl-files from: ${ENUM_DIR}
find ${SHAPE_DIR} -type f -name '*.ttl' ! -name '_*.ttl' -exec cat {} + >> ${SHAPE_FILE}
echo Built shapes: ${SHAPE_DIR}

java -jar $WIDOCO_PATH -ontFile $SHAPE_FILE -outFolder $SHAPE_DOC_DIR -noPlaceHolderText -rewriteAll
echo Built shapes documentation: ${SHAPE_DOC_DIR}

echo SHAPES READY