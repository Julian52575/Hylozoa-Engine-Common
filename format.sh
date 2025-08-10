#!/bin/bash
# 2025 Bottiglione Julian <julian.bottiglione@epitech.eu>

if (( $# < 1 ));
then
    echo -e "Usage:\t $0 {src_folder} [--check]"
    exit 84
fi

FORMAT_LIST=$(find "$1" \( -name "*.hpp" -o -name "*.cpp" \))

if [[ "$2" == "--check" ]];
then
    echo -e "${YELLOW}Verifying files:\n${FORMAT_LIST}...${NC}"
    clang-format --dry-run -Werror $FORMAT_LIST > /dev/null 2>&1
else
    echo -e "${YELLOW}Formating sources:\n${FORMAT_LIST}...${NC}"
    clang-format -i $FORMAT_LIST
fi

if (( $? == 0 ));
then
    echo -e "${GREEN}Success !${NC}"
else
    echo -e "${RED}Failure ! Run the formater to fix.${NC}"
    exit 84
fi