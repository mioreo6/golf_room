class Public::HomesController < ApplicationController
  def top
    @posts = Post.order('id DESC').limit(5)
  end

# ゲストログイン
  def guest_sign_in
      customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64(6)#パスワードランダム生成
      customer.name = "ゲスト"#ゲストログイン時のユーザー名

      
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログイン中'
  end

  def about
  end
end
