namespace :db do
  desc "import salesmen"
  task :salesmen do
    SALES_MEN = %w(袁贝贝,张飘,陶俊杰,赵振华,梁峻)
    SALES_MEN_MOBILE = %w(袁贝贝,张飘,陶俊杰,赵振华,梁峻)

    SALES_MEN.each_with_index do |sales, index|
      User.create name: sales,
        mobile: SALES_MEN_MOBILE[index],
        password: ('a'..'z').to_a.shuffle[1..10].join,
        invitation_token: ('a'..'z').to_a.shuffle[1..8].join
    end

  end
end
