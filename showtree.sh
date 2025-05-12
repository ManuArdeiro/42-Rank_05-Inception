#!/bin/bash

# Función para detectar si un archivo es de texto
is_text_file() {
  file -b --mime-encoding "$1" | grep -q -v 'binary'
}

# Mostrar estructura de directorios (excluyendo .git)
echo -e "\033[1;32m=== ESTRUCTURA DE DIRECTORIOS ===\033[0m"
tree -a -I '.git' --dirsfirst

# Mostrar contenido de archivos legibles
echo -e "\n\033[1;32m=== CONTENIDO DE ARCHIVOS DE TEXTO ===\033[0m"
find . -type f ! -path '*/.git/*' | while read -r file; do
  if is_text_file "$file"; then
    echo -e "\n\033[1;34m=== $file ===\033[0m"
    cat "$file"
    echo -e "\033[1;30m----------------------------------------\033[0m"
  else
    echo -e "\n\033[1;31m=== $file (archivo binario, omitido) ===\033[0m"
  fi
done