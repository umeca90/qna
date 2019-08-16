# Q&A

# Учебный проект от школы Thinknetica

# Цель проекта
Cоздать ресурс, на котором пользователи могут задавать вопросы, отвечать на эти вопросы, давать комментарии и голосовать за лучьший ответ. К вопросам можно приложить ссылки либо файлы.

# Аутентификация протокол OAuth
Пользователи могут зарегистироваться и войти через соц сети.

# Авторизация
Реализована через гем cancancan.

# Рейтинг
Автор вопроса, может выбрать лучший ответ.

Любой зарегистрированный пользователь может проголосовать за чужой вопрос.

# Подписка и рассылка ActiveJob
Пользователь может подписаться на вопрос о получение уведомлений о новых ответах на его почтовый адрес.

# ActionCable
Обновление ответов происходит автоматически, через websocket.

# Api 
Реализован через гем doorkeeper.
api/v1/questions/...
api/v1/answers/...

# Полнотекстовый поиск через Sphinx

