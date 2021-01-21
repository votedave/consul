class Shared::SDG::GoalStatsComponent < ApplicationComponent
  with_collection_parameter :goal

  attr_reader :goal

  def initialize(goal:)
    @goal = goal
  end

  private

    def approved_budget
      number_to_currency(goal.budget_investments.winners.sum(:price), precision: 0)
    end
end
