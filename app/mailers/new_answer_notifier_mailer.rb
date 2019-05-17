class NewAnswerNotifierMailer < ApplicationMailer
  def notify_about_new_answer(answer)
    @answer = answer
    mail to: answer.question.author.email,
         subject: 'A new answer posted in your question!'
  end
end
