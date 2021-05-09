require 'rails_helper'

RSpec.describe User, type: :model do

  it "名、メール、パスワードがある場合、有効である" do
　　 # userのそれぞれのカラムに対して値を入れてオブジェクト化する
    user = User.new(

     email: "testman@example.com",

     )
     # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
     expect(user).to be_valid
  end
end
