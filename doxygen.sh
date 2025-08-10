#!/bin/bash
# 2025 Bottiglione Julian <julian.bottiglione@epitech.eu>
#   Note:   This script requires the following packages:
#   graphviz
#   doxygen

if (( $# < 2 ));
then
    echo -e "Usage:\t $0 {project_name} {src_folder}"
    exit 84
fi


DOXYFILE_DEFAULT="DOXYFILE_ENCODING = UTF-8
PROJECT_NAME = \"$1\"
EXTRACT_ALL = YES
FILE_PATTERNS = *.cpp *.hpp
INPUT = \"$2\"
RECURSIVE = YES

CLASS_GRAPH = YES
HAVE_DOT = YES
CALL_GRAPH = YES
CALLER_GRAPH = YES
DIRECTORY_GRAPH = YES"

if ! doxygen -v; then
    echo "You need to install doxygen first."
    exit 84
fi

test -d doxygen
if [ $? != 0 ]
then
    test -f doxygen
    if [ $? == 0 ]
    then
        rm -rf doxygen
    fi
    mkdir doxygen
fi

test -f doxygen/Doxyfile
if [ $? != 0 ]
then
    echo "${DOXYFILE_DEFAULT}" > doxygen/Doxyfile
fi

doxygen ./doxygen/Doxyfile
if [ $? != 0 ]
then
    echo -e "${RED}An error occured when generating the documentation...${NC}"
    exit 84
fi
test -d doxygen/html/ && rm -r doxygen/html/
test -d doxygen/latex/ && rm -r doxygen/latex/
mv -f html/ doxygen/
mv -f latex/ doxygen/
echo -e "${GREEN}Succesfuly generated the documentation !\nLook at doxygen/index.html or doxygen/class.png !${NC}"
exit 0