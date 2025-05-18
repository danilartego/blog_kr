# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate

    # @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    # @answers = @question.answers.order(created_at: :desc)
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = 'Question was successfully created.'
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)

      # Удаление отмеченных изображений
      params[:question][:image_ids]&.each do |id|
        image = @question.images.find(id)
        image.purge
      end

      # Удаление отмеченных файлов
      params[:question][:file_ids]&.each do |id|
        file = @question.files.find(id)
        file.purge
      end

      flash[:success] = 'Question was successfully updated.'
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question was successfully deleted.'
    redirect_to questions_path
  end

  private

  def question_params
    params.expect(question: [:title, :body, { images: [], files: [] }])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
