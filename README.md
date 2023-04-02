# timur8298_microservices
timur8298 microservices repository

# HW-12 Технология контейнеризации. Введение в Docker.
Установка Docker, команды docker ps, docker images, docker run, docker exec, docker commit

Задания со **
Сравнение вывода команд docker inspect image и docker inspect container:
Docker Image - это неизменяемый файл, содержащий исходный код, библиотеки, 
зависимости, инструменты и другие файлы, необходимые для запуска приложения.
Так как образы являются просто шаблонами, их нельзя создавать или запускать. 
Этот шаблон можно использовать в качестве основы для построения контейнера. 
Контейнер - это, в конечном счете, просто образ. 
При создании контейнера поверх образа добавляет слой, доступный для записи, 
что позволяет менять его по своему усмотрению.
Образ - это шаблон, на основе которого создается контейнер, существует отдельно и не может быть изменен. 
При запуске контейнерной среды внутри контейнера создается копия файловой системы (docker образа) для чтения и записи.
Также на основе анализа вывода команд, можно увидеть, что у образа нет сетевых настроек. У контейнера они есть.

# HW-13 Docker контейнеры. Docker под капотом.
Сборка нашего приложения на Docker. Подготовка файлов, сборка контейнера, запуск, проверка работы.
Docker hub: регистрация, аутенцификация, загрузка готового образа timur8298/otus-reddit:1.0

Задания со **
Автоматизация поднятия нескольких инстансов в YC установка на них докера и запуск нашего образа timur8298/otus-reddit:1.0
Поднятие инстансов с помощью terraform,  их количество задается переменной
(выполнить terraform apply в папке infra/terraform, по шаблону inventory.tmpl будет создан файл inventory для ansible )
Ansible с использованием динамического инвентори для установки докера и запуска там образа приложения
Шаблон пакера, который делает образ с уже установленным Docker.

# HW-14 Docker образы. Микросервисы
Разбиваем приложение на несколько компонентов, запускаем
Оптимизируем сборку приложения
Используем volume для сохранения базы mongo вне контейнера

Задания со **
Для запуска приложения с другими сетевыми алиасами укажем их и передадим значения переменных через ENV переменные:
docker run -d --network=reddit --network-alias=post_db_1 --network-alias=comment_db_1 mongo:4.2-rc
docker run -d --network=reddit -e POST_DATABASE_HOST=post_db_1 -e POST_DATABASE=posts_1 --network-alias=post_1 timur8298/post:1.0 
docker run -d --network=reddit -e COMMENT_DATABASE_HOST=comment_db_1 -e COMMENT_DATABASE=comments_1 --network-alias=comment_1 timur8298/comment:1.0
docker run -d --network=reddit -e POST_SERVICE_HOST=post_1 -e COMMENT_SERVICE_HOST=comment_1 -p 9292:9292 timur8298/ui:1.0

Для оптимизации сборок применил сборки на alpine, что существенно сократило используемое место на диске
~/timur8298_microservices/src# docker image ls
REPOSITORY          TAG       IMAGE ID       CREATED              SIZE
timur8298/ui        2.0       4ac517b0a30a   9 seconds ago        83.5MB
timur8298/comment   2.0       784e5c67dbc6   About a minute ago   80.5MB
timur8298/ui        1.0       0d5b51aa4d8e   2 minutes ago        763MB
timur8298/comment   1.0       b3f373f73e55   3 minutes ago        760MB
timur8298/post      1.0       50c0aa586863   4 minutes ago        107MB
mongo               4.2-rc    3974c5e3b793   6 days ago           388MB

Для работы пришлось использовать образ mongo не latest, а конкретной версии 4.2-rc, иначе новая монга не понимала устаревших инструкций.
Также не корректно работало приложение post, решилось добавлением зависимости в файл requirements.txt

# HW-16 Сетевое взаимодействие Docker контейнеров. Docker Compose. Тестирование образов
Пробуем разные сетевые драйвера None, host network driwer, bridge исследование их работы
Docker-compose, параметризация с помощью файла .env
Имя проекта в docker-compose можно сменить при запуске, при помощи ключа -p "project_name" либо при помощи переменной COMPOSE_PROJECT_NAME
(https://docs.docker.com/compose/environment-variables/envvars/#compose_project_name)

Задания со **
создан файл docker-compose.override.yml который будет переопределять действующие контейнеры

# HW-17 Введение в мониторинг. Модели и принципы работы систем мониторинга
Запустил Prometheus в докере совместно с другими сервисами приложения c помощью docker-compose.
Не работал мониторинг comment. Оказалось неверно был указан хост с БД. После замены - заработало.

Задание со **
Добавил экспортёр для mongoDB из образа percona/mongodb_exporter:0.37.0. Обновил конфигурационный файл prometheus.yml
Добавил blackbox экспортёр из образа prom/blackbox-exporter:v0.23.0. 
Добавил мониторинг сервисов comment, post, ui и соответственно обновил конфигурационный файл prometheus.yml
Создал Makefile, который умеет:
Билдить любой или все образы, которые сейчас используются
Умеет пушить их в докер хаб
Умеет запускать, или останавливать проект
