#!/usr/bin/env python3
import sys
for arg in sys.argv[1:]:
    print(f"{int(arg):02x}:", end="")
print("\n")
