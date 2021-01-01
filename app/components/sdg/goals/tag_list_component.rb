class SDG::Goals::TagListComponent < ApplicationComponent
  attr_reader :record, :limit
  delegate :link_list, to: :helpers

  def initialize(record, limit: nil)
    @record = record
    @limit = limit
  end

  def render?
    SDG::ProcessEnabled.new(record.class.name).enabled?
  end

  private

    def goals
      record.sdg_goals.order(:code).limit(limit)
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
      polymorphic_index(record, advanced_search: { goal: goal.code })
    end

    def filter_text(goal)
      t("sdg.goals.filter.link",
        resources: record.model_name.human(count: :other),
        code: goal.code)
    end
end
