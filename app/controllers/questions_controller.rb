class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def update
    if @question.update(question_params)
      flash[:success] = "Question was successfully updated."
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question was successfully created."
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @question.destroy
    flash[:success] = "Question was successfully deleted."
    redirect_to questions_path
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end