module TagsHelper
  def taggable_path(taggable)
    taggable_type = taggable.class.name.underscore
    case taggable_type
    when "debate"
      debate_path(taggable)
    when "proposal"
      proposal_path(taggable)
    when "budget/investment"
      budget_investment_path(taggable.budget_id, taggable)
    when "legislation/proposal"
      legislation_process_proposal_path(@process, taggable)
    else
      "#"
    end
  end
end
