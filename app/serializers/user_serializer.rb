# 用户 API 返回数据结构
# == attributes
# - *id*         [Integer] 用户编号
# - *login*      [String] 用户名
# - *name*       [String] 用户姓名
# - *avatar_url* [String] 头像 URL
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :roles, :success, :message #, :avatar_url

 # def avatar_url
 #   object.avatar.url
 #  end
  def success
    object.member?
  end

  def message
    success ? '会员' : '非会员'
  end
end
