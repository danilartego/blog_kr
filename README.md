# README

Тестовый проект по урокам Ruby on Rails 6/7: уроки (Ilya Krukowski)

Ссылка на уроки:
https://www.youtube.com/playlist?list=PLWlFXymvoaJ_IY53-NQKwLCkR-KkZ_44-

Используется Rails 8

История уроков

Создание PagesController

```sh
app/controllers/pages_controller.rb
```

Добавление представления для PagesController

```sh
app/views/pages/index.html.erb
```

Добавление маршрута для PagesController

```sh
#config/routes.rb`:
root 'pages#index'
```

Создание базы данных

```sh
rails db:create RAILS_ENV=development
```

Создание модели Question

```sh
rails g model Question title:string body:text
```

Миграция базы данных

```sh
rails db:migrate
```

Создание контроллера QuestionsController

```sh
#app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end
end
```

Добавление представления для QuestionsController

```erb
#app/views/questions/index.html.erb
<h1>Questions</h1>
<% @questions.each do |question| %>
  <h3><%= question.title %></h3>

  <time datetime="<%= question.formatted_created_at  %>">
    <%= question.formatted_created_at %> ||
    <%= time_ago_in_words(question.created_at) %> назад
  </time>
  <p><%= question.body %></p>
<% end %>
```

Добавление маршрута для QuestionsController

```sh
#config/routes.rb`:
get "/questions", to: "questions#index"
```

Добавление меню в представление

```erb
#app/views/layouts/application.html.erb`
<nav>
  <%= link_to 'Home', root_path %>
  <%= link_to 'Questions', questions_path %>
</nav>
<%= yield %>
```

Создание форм, методов и маршрутов для создания, обновления и удаления вопросов

Добавление Bootstrap в проект

```Gemfile
gem "dartsass-rails"
gem "bootstrap", "~> 5.3.3"
gem "foreman"
```

Запустить команды:
`bundler`
`rails dartsass:install`

```Prockile.dev
web: bin/rails server -b 0.0.0.0 -p 3000
css: bin/rails dartsass:watch
```
Запустить команду: `foreman start -f Procfile.dev`

Добавление Flash сообщений в представления в контроллере

`flash[:success] = "Question was successfully created."`

Добавить обработку Flash сообщений в представления
```erb
#app/views/layouts/application.html.erb`
<% flash.each do |key, value| %>
  <%= tag.div value, class: "alert alert-#{key}", role: "alert" %>
<% end %>
```

Добавление обработки ошибок

`<% object.errors.full_messages.join(", ") if object.errors.full_messages.any? %>`


Параметры которые нужны для обработки ошибок

`render :new, status: :unprocessable_entity` and `render :edit, status: :unprocessable_entity`

