class Admin::MerchantsController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    render file: "/app/views/merchants/show.html", status: 200
  end

  def update

  end
end
