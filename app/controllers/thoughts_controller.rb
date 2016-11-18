class ThoughtsController < ApplicationController

  def explore
    @thoughts = Thought.created_after(24.hours.ago).order('created_at DESC')
  end

  def create
    thought = Thought.new(create_thought_params)

    if thought.save
      redirect_to diary_path, notice: 'Votre pensée vient d’être publiée.'
    else
      redirect_to diary_path, alert: 'Votre pensée n’a pas pu être publiée.'
    end
  end

private

  def create_thought_params
    params.require(:thought).permit(:content).merge(user: current_user)
  end

end
