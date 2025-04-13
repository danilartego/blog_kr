class AnswersController < ApplicationController
  before_action :set_question!
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

  def destroy
    answer = @question.answers.find(params[:id])
    answer.destroy
    flash[:success] = 'Answer was successfully deleted.'
    redirect_to question_path(@question)

  end
  

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end
end