class AddQuestionnaireProgressToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :questionnaire_progress, :json
  end
end
