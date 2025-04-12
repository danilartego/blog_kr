class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def update
    @question = Question.find(params[:id])
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
    @question = Question.find_by id: params[:id]
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Question was successfully deleted."
    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end