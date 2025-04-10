# README
Тестовый проект по урокам Ruby on Rails 6/7: уроки (Ilya Krukowski)

Ссылка на уроки:
https://www.youtube.com/playlist?list=PLWlFXymvoaJ_IY53-NQKwLCkR-KkZ_44-

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
