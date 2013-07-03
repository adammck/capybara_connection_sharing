class WidgetsController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def froobicate
    Widget.where("id = SLEEP(0.3)").to_a
    render text: "OK"
  end
end
