# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_question!
  before_action :set_answer!, except: [:create]

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      flash[:success] = 'Answer was successfully created.'
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order(created_at: :desc)
      render 'questions/show', status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:success] = 'Answer was successfully updated.'
      redirect_to question_path @question, anchor: "answer-#{@answer.id}" # якори не работают, почему? (rails 8.0.2) turbo stream?
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer was successfully deleted.'
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.expect(answer: [:body])
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end

  def set_answer!
    @answer = @question.answers.find(params[:id])
  end
end
