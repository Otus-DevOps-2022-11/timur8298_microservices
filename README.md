# timur8298_microservices
timur8298 microservices repository

#HW-12 Технология контейнеризации. Введение в Docker.
Установка Docker, команды docker ps, docker images, docker run, docker exec, docker commit
Задания со **
Сравнение вывода команд docker inspect <image> и docker inspect <container>:
Docker Image - это неизменяемый файл, содержащий исходный код, библиотеки, зависимости, инструменты и другие файлы, необходимые для запуска приложения.
Так как образы являются просто шаблонами, их нельзя создавать или запускать. Этот шаблон можно использовать в качестве основы для построения контейнера. 
Контейнер - это, в конечном счете, просто образ. При создании контейнера поверх образа добавляет слой, доступный для записи, что позволяет менять его по своему усмотрению.
Образ - это шаблон, на основе которого создается контейнер, существует отдельно и не может быть изменен. При запуске контейнерной среды внутри контейнера создается копия 
файловой системы (docker образа) для чтения и записи.
Также на основе анализа вывода команд, можно увидеть, что у образа нет сетевых настроек. У контейнера они есть.

#HW-13 Docker контейнеры. Docker под капотом.
Сборка нашего приложения на Docker. Подготовка файлов, сборка контейнера, запуск, проверка работы.
Docker hub: регистрация, аутенцификация, загрузка готового образа timur8298/otus-reddit:1.0
Задания со **
Автоматизация поднятия нескольких инстансов в YC установка на них докера и запуск нашего образа timur8298/otus-reddit:1.0
Поднятие инстансов с помощью terraform,  их количество задается переменной
(выполнить terraform apply в папке infra/terraform, по шаблону inventory.tmpl будет создан файл inventory для ansible )
Ansible с использованием динамического инвентори для установки докера и запуска там образа приложения
Шаблон пакера, который делает образ с уже установленным Docker.