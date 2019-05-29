class Admin::MerchantsController < Admin::BaseController

  def enable
    User.update(params[:id], active: true)
    flash[:note] = "Merchant has been enabled."
    redirect_to '/merchants'
  end

  def disable
    User.update(params[:id], active: false)
    flash[:note] = "Merchant has been disabled."
    redirect_to '/merchants'
  end

  def downgrade
    merchant = User.find(params[:merchant_id])
    merchant.deactivate_all_items
    merchant.downgrade_to_user

    flash[:notice] = "#{merchant.name} has been downgraded to a User."

    redirect_to admin_user_path(merchant)
  end
end
