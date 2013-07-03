require 'test_helper'

class WidgetsTest < ActionDispatch::IntegrationTest
  setup do
    10.times do
      Widget.create(name: rand(2**64).to_s)
    end
  end

  #
  # This test fails with no patch (because the widgets created in setup aren't
  # visible to the web thread), but works with either the capybara patch or
  # @mperham's patch.
  #
  test 'shows all widgets' do
    visit '/widgets'

    Widget.find_each do |widget|
      assert page.has_content?(widget.name), "page should have widget: #{widget.name}"
    end
  end

  #
  # This test fails with no patch (as above), but also fails with the capybara
  # patch. It works with @mperham's patch.
  #
  test 'can froobicate widgets' do
    visit '/widgets'
    click_on "Start Froobication"

    100.times do
      Widget.all.to_a
    end

    assert find("#output").has_content?('OK')
  end
end
