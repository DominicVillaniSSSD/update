#!/bin/bash
source setup.sh
print_logo() {
echo -e "${BLUE}
  SSSSS    SSSSS   SSSSS    DDDDD  
 S     S  S     S  S     S  D    D 
 S        S        S        D     D
  SSSSS    SSSSS    SSSSS   D     D
       S        S        S  D     D
 S     S  S     S  S     S  D    D 
  SSSSS    SSSSS    SSSSS   DDDDD  
${NC}"
}

print_finished() {
    echo -e "${BLUE}"
    cat << 'EOF'
  ______ _       _     _              _
 |  ____(_)     (_)   | |            | |
 | |__   _ _ __  _ ___| |__   ___  __| |
 |  __| | | '_ \| / __| '_ \ / _ \/ _` |
 | |    | | | | | \__ \ | | |  __/ (_| |
 |_|    |_|_| |_|_|___/_| |_|\___|\__,_|

EOF
    echo -e "${NC}"  # Reset text color to default
}