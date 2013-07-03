class WidgetsTest < ActionDispatch::IntegrationTest
  setup do
    10.times do
      Widget.create(name: rand(2**64).to_s)
    end
  end

  test 'shows all widgets' do
    visit '/widgets'

    Widget.find_each do |widget|
      assert page.has_content?(widget.name), "page should have widget: #{widget.name}"
    end
  end
end
