#!/bin/bash
# Скрипт для конвертации различных форматов офисных документов
# с помощью LibreOffice
# ИСПОЛЬЗОВАНИЕ:
# convert.sh type file

help_msg() {
    cat << EOF
convert.sh - скрипт для конвертации одних форматов офисных документов в другие.
Использует LibreOffice.

ИСПОЛЬЗОВАНИЕ:
convert.sh type file

type - тип получаемого файла;
file - файл для конвертации.
EOF
}

if [ ! -e "$2" ]; then
    echo -e "Не указан файл для конвертации! \n\n"
    help_msg
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "Не найден файл для конвертации!"
    exit 1
fi

# Закрытие всех запущенных процессов LibreOffice
killall -u `whoami` -q soffice

# Конвертация
soffice --headless --convert-to "$1" "$2"

if [ $? != 0 ]; then
    echo "soffice вернул код завершения, отличный от нуля!"
    exit $?
fi
