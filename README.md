# 🐧 ОС GNU/Linux та Bash

> Практична робота 23 · Вступ у Bash · Системне програмування
>
> 🌐 Веб-сторінка: **https://lo1di.github.io/linux-lab/**

## Зміст
1. [Коротка інформація про ОС GNU/Linux](#1-коротка-інформація-про-ос-gnulinux)
2. [Найпопулярніші дистрибутиви](#2-найпопулярніші-дистрибутиви)
3. [Приклади команд Linux CLI](#3-приклади-команд-linux-cli)
4. [BASH-скрипт авторизації](#4-bash-скрипт-авторизації)
5. [Джерела інформації](#5-джерела-інформації)

---

## 1. Коротка інформація про ОС GNU/Linux

**GNU/Linux** — сімейство вільних Unix-подібних операційних систем на основі **ядра Linux** та програм **проєкту GNU**. Код відкритий: його можна вільно використовувати, змінювати та поширювати.

- **1983** — Річард Столлман оголошує проєкт GNU;
- **1991** — Лінус Торвальдс публікує першу версію ядра Linux;
- **1992** — ядро переходить на ліцензію GNU GPL.

**Складові:** ядро, оболонка (`bash`), утиліти GNU, графічне середовище, менеджер пакетів.

Linux працює на більшості серверів, на всіх суперкомп'ютерах TOP500 і є основою Android.

---

## 2. Найпопулярніші дистрибутиви

| Дистрибутив | Основа | Менеджер пакетів | Особливість |
|---|---|---|---|
| Ubuntu | Debian | apt | Найпопулярніший, для початківців і серверів |
| Debian | — | apt | Стабільний, основа для багатьох інших |
| Linux Mint | Ubuntu | apt | Зручний для переходу з Windows |
| Fedora | Red Hat | dnf | Свіже ПЗ, сучасні технології |
| Arch Linux | — | pacman | Мінімалізм, rolling release |
| RHEL | — | dnf | Корпоративні сервери |
| openSUSE | — | zypper | Інструмент YaST |
| Kali Linux | Debian | apt | Кібербезпека |

---

## 3. Приклади команд Linux CLI

| Команда | Призначення | Приклад |
|---|---|---|
| `pwd` | Шлях до поточного каталогу | `pwd` |
| `echo` | Вивести текст / змінну | `echo "Hello, $USER"` |
| `ls` | Вміст каталогу | `ls -la` |
| `cd` | Змінити каталог | `cd /home/student` |
| `touch` | Створити порожній файл | `touch notes.txt` |
| `mkdir` | Створити каталог | `mkdir -p lab/src` |
| `cp` | Копіювати | `cp notes.txt backup.txt` |
| `mv` | Перемістити / перейменувати | `mv backup.txt lab/` |
| `rm` | Видалити | `rm -i notes.txt` |
| `history` | Історія команд | `history 10` |

```bash
student@linux:~$ mkdir lab23 && cd lab23
student@linux:~/lab23$ touch a.txt b.txt
student@linux:~/lab23$ cp a.txt c.txt
student@linux:~/lab23$ mv b.txt notes.txt
student@linux:~/lab23$ rm a.txt
student@linux:~/lab23$ ls
c.txt  notes.txt
```

---

## 4. BASH-скрипт авторизації

Файл: [`auth.sh`](auth.sh) — імітація входу в систему в текстовому режимі:

- паролі зберігаються як хеші **SHA-256**;
- прихований ввід пароля (`read -s`);
- **3 спроби**, потім блокування на 5 секунд;
- після входу — міні-сесія з меню та `logout`.

Тестові акаунти: `admin` / `admin123`, `student` / `linux2026`.

```bash
chmod +x auth.sh
./auth.sh
```

---

## 5. Джерела інформації

1. [Linux та система GNU — gnu.org](https://www.gnu.org/gnu/linux-and-gnu.uk.html)
2. [The Linux Kernel Archives](https://www.kernel.org/)
3. [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
4. [LinuxCommand.org](https://linuxcommand.org/)
5. [LinuxSimply — Bash Scripting Tutorial](https://linuxsimply.com/bash-scripting-tutorial/)
6. [DistroWatch](https://distrowatch.com/)
7. [Linux — Вікіпедія](https://uk.wikipedia.org/wiki/Linux)

---
*Сайт розроблено за допомогою Claude (Anthropic)*
