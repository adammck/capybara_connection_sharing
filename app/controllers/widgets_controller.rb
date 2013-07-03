class WidgetsController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def froobicate
    @widget = Widget.limit(1).first
    Widget.connection.execute(%Q<SELECT SLEEP(3)>) # something really expensive
    Widget.connection.execute(%Q<UPDATE widgets SET name="froob" where id=#{@widget.id}>)
    render text: "OK"
  end
end
