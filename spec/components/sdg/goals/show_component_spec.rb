require "rails_helper"

describe SDG::Goals::ShowComponent, type: :component do
  let!(:goal_1) { SDG::Goal[1] }

  before do
    Setting["feature.sdg"] = true
    allow(SDG::Widget::Feed).to receive(:for_goal).and_return([])
    allow(Widget::Feeds::ParticipationComponent).to receive(:new).and_return([])
  end

  it "renders a heading" do
    component = SDG::Goals::ShowComponent.new(goal_1)

    render_inline component

    expect(page).to have_css ".goal-title"
    expect(page).to have_content "No Poverty"
  end

  it "renders a long description" do
    component = SDG::Goals::ShowComponent.new(goal_1)

    render_inline component

    expect(page).to have_css "#description_goal_#{goal_1.code}"
    expect(page).to have_content "Globally, the number of people living in extreme poverty declined from 36 per cent in 1990 to 10 "
    expect(page).to have_css "#read_more_goal_#{goal_1.code}"
    expect(page).to have_content "Read more about No Poverty"
    expect(page).to have_css "#read_less_goal_#{goal_1.code}.hide"
    expect(page).to have_content "Read less about No Poverty"
  end
end
