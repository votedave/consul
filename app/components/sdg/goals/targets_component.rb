class SDG::Goals::TargetsComponent < ApplicationComponent
  attr_reader :goal

  def initialize(goal)
    @goal = goal
  end

  private

    def global_targets
      goal.targets
    end

    def local_targets
      goal.local_targets
    end
end
