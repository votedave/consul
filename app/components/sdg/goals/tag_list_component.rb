class SDG::Goals::TagListComponent < ApplicationComponent
  attr_reader :record_or_name, :limit
  delegate :link_list, to: :helpers

  def initialize(record_or_name, limit: nil)
    @record_or_name = record_or_name
    @limit = limit
  end

  def render?
    SDG::ProcessEnabled.new(record_or_name).enabled?
  end

  private

    def goals
      if record_or_name.respond_to?(:sdg_goals)
        record_or_name.sdg_goals.order(:code).limit(limit)
      else
        SDG::Goal.order(:code).limit(limit)
      end
    end

    def goal_links
      goals.map do |goal|
        [
          render(SDG::Goals::IconComponent.new(goal)),
          index_by_goal(goal),
          title: filter_text(goal)
        ]
      end
    end

    def index_by_goal(goal)
      polymorphic_index(record_or_name, advanced_search: { goal: goal.code })
    end

    def filter_text(goal)
      t("sdg.goals.filter.link",
        resources: model_name.human(count: :other),
        code: goal.code)
    end

    def model_name
      if record_or_name.respond_to?(:model_name)
        record_or_name.model_name
      else
        record_or_name.constantize.model_name
      end
    end
end
