class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    unless @answer.save
      flash[:notice] = @answer.errors.full_messages
    end

    respond_to do |format|
      if @answer.save
        format.html { render partial: 'questions/answers', layout: false }
        format.json { render json: @answer }
      else
        format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.destroy!
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
