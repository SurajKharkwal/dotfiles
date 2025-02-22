#!/bin/bash

FILE_NAME="$1"
ABSOLUTE_PATH=$(realpath "$FILE_NAME")

# Function to run C files
c() {
  gcc "$ABSOLUTE_PATH" -o temp_c_exec && ./temp_c_exec
  rm -f temp_c_exec
}

# Function to run C++ files
cpp() {
  g++ "$ABSOLUTE_PATH" -o temp_cpp_exec && ./temp_cpp_exec
  rm -f temp_cpp_exec
}

# Function to run MySQL (or MariaDB) files
mysql() {
  mariadb --skip_ssl -u root -p my-server <"$ABSOLUTE_PATH"
}

# Function to run Python files
python() {
  python3 "$ABSOLUTE_PATH"
}

# Function to run Java files
java() {
  javac "$ABSOLUTE_PATH" && java "${ABSOLUTE_PATH%.*}"
}

# Function to run Rust files
rust() {
  rustc "$ABSOLUTE_PATH" -o temp_rust_exec && ./temp_rust_exec
  rm -f temp_rust_exec
}

# Check the file extension and call the appropriate function
case "${FILE_NAME##*.}" in
cpp) cpp ;;
sql) mysql ;;
py) python ;;
java) java ;;
rs) rust ;;
c) c ;;  # Added support for C files
*) echo "Unsupported file type." ;;
esac
