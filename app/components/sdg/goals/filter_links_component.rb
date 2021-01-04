class SDG::Goals::FilterLinksComponent < ApplicationComponent
  attr_reader :record_or_name, :limit

  def initialize(record_or_name)
    @record_or_name = record_or_name
  end

  def render?
    SDG::ProcessEnabled.new(record_or_name).enabled?
  end

  private

    def heading
      t("sdg.goals.filter.heading")
    end
end
