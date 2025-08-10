#!/bin/bash
# 2025 Bottiglione Julian <julian.bottiglione@epitech.eu>

if (( $# < 1 ));
then
    echo -e "Usage:\t $0 {src_folder} {compilation_database}"
    exit 84
fi
if (( $# > 1 ));
then
    COMPILATION_DATABASE="$2"
else
    COMPILATION_DATABASE="build/compile_commands.json"
    echo -e "${YELLOW}Warning: No compilation database precised. Resorting to ${COMPILATION_DATABASE}.${NC}"
fi

TIDY_LIST=$(find "$1" \( -name "*.hpp" -o -name "*.cpp" \))
echo -e "${YELLOW}Linting sources:\n ${TIDY_LIST}...${NC}"

clang-tidy $TIDY_LIST -p $COMPILATION_DATABASE
if (( $? == 0 ));
then
    echo -e "${GREEN}Success !${NC}"
fi