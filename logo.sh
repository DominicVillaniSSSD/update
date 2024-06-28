#!/bin/bash
source setup.sh
print_logo() {
echo "
  SSSSS    SSSSS   SSSSS    DDDDD  
 S     S  S     S  S     S  D    D 
 S        S        S        D     D
  SSSSS    SSSSS    SSSSS   D     D
       S        S        S  D     D
 S     S  S     S  S     S  D    D 
  SSSSS    SSSSS    SSSSS   DDDDD  
"
}

print_finished() {
  # echo -e "${RED}This text is red${NC}"
  echo -e "${BLUE}finished"
}
