Wadjet.controllers :fakewidget, :map => '/widgets/fakewidget' do  
  
  get :render_fragment, :map => '/widgets/render_fragment/:slug'  do
    @widget = current_account.dashboard.widgets(:name => 'fakewidget')
    @widget = @widget.first
    render "widgets/#{@widget.view}"
  end
end