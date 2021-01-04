require "rails_helper"

describe SDG::Goals::FilterLinksComponent, type: :component do
  let(:component) { SDG::Goals::FilterLinksComponent.new("Debate") }

  before do
    Setting["feature.sdg"] = true
    Setting["sdg.process.debates"] = true
  end

  it "renders a title" do
    render_inline component

    expect(page).to have_content "Filters by SDG"
  end
end
