class Admin::MerchantsController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    render file: "/app/views/merchants/show.html", status: 200
  end

  def update
    user = User.find_by(id: params[:id])
    if params[:commit] == "enable"

      User.update(user.id,active: true)
      flash[:message] = "Merchant #{user.id} enabled"
    elsif params[:commit] == "disable"
      User.find(params[:id]).update(active: false)
      flash[:message] = "Merchant #{user.id} disabled"
    end
    redirect_to merchants_path
  end
end
