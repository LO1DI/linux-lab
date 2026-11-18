#!/bin/bash
# =====================================================
#  ПР 23. Вступ у Bash — імітація авторизації в системі
#  Запуск:  chmod +x auth.sh && ./auth.sh
#  Тестові акаунти:  admin / admin123,  student / linux2026
# =====================================================

# ---------- Кольори ----------
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

# ---------- "База" користувачів: логін -> SHA-256 хеш пароля ----------
# Паролі не зберігаються у відкритому вигляді, лише їхні хеші
declare -A USERS=(
    [admin]="240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9"   # admin123
    [student]="c4f9fa0b227bd46a37bf49b6f56d8b8750b7e46d39d79654f440e139916d8581" # linux2026
)

MAX_ATTEMPTS=3      # кількість спроб входу
LOCK_TIME=5         # секунд блокування після невдалих спроб

# ---------- Функція: хешування пароля ----------
hash_password() {
    printf '%s' "$1" | sha256sum | cut -d' ' -f1
}

# ---------- Функція: заголовок ----------
banner() {
    clear
    echo -e "${CYAN}=========================================${NC}"
    echo -e "${CYAN}   GNU/Linux $(uname -r 2>/dev/null)${NC}"
    echo -e "${CYAN}   $(hostname 2>/dev/null) login — $(date '+%d.%m.%Y %H:%M')${NC}"
    echo -e "${CYAN}=========================================${NC}"
}

# ---------- Функція: сесія після входу ----------
session() {
    local user=$1
    echo -e "\n${GREEN}Вхід виконано успішно. Вітаємо, ${user}!${NC}"
    echo -e "Останній вхід: $(date '+%a %d %b %Y %H:%M:%S')"
    echo
    while true; do
        echo -e "${YELLOW}1${NC} — інформація про користувача"
        echo -e "${YELLOW}2${NC} — поточна дата і час"
        echo -e "${YELLOW}3${NC} — вміст поточного каталогу"
        echo -e "${YELLOW}0${NC} — вийти із системи (logout)"
        read -p "${user}@system:~\$ " cmd
        case $cmd in
            1) echo -e "Користувач: ${GREEN}${user}${NC}, роль: $([[ $user == admin ]] && echo адміністратор || echo користувач)" ;;
            2) date ;;
            3) ls ;;
            0) echo -e "${CYAN}logout. Сеанс користувача ${user} завершено.${NC}"; return ;;
            *) echo -e "${RED}Невідома команда${NC}" ;;
        esac
        echo
    done
}

# ---------- Головна логіка авторизації ----------
banner
attempt=1
while (( attempt <= MAX_ATTEMPTS )); do
    read -p "login: " username
    read -s -p "Password: " password     # -s — пароль не відображається
    echo

    if [[ -z $username || -z $password ]]; then
        echo -e "${RED}Логін і пароль не можуть бути порожніми.${NC}"
    elif [[ -n ${USERS[$username]} && ${USERS[$username]} == "$(hash_password "$password")" ]]; then
        session "$username"
        exit 0
    else
        left=$(( MAX_ATTEMPTS - attempt ))
        echo -e "${RED}Login incorrect.${NC} Залишилось спроб: ${left}"
    fi
    (( attempt++ ))
    echo
done

# ---------- Блокування після невдалих спроб ----------
echo -e "${RED}Забагато невдалих спроб! Доступ заблоковано на ${LOCK_TIME} с.${NC}"
for (( i = LOCK_TIME; i > 0; i-- )); do
    printf "\rРозблокування через %d с... " "$i"
    sleep 1
done
echo -e "\n${YELLOW}Спробуйте запустити скрипт ще раз.${NC}"
exit 1
