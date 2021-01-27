class SDG::Goals::TargetComponent < ApplicationComponent
  attr_reader :targets

  def initialize(targets)
    @targets = targets
  end

  private

    def type
      if targets.model.name == "SDG::Target"
        "global"
      else
        "local"
      end
    end
end
