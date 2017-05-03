# README

# 部署
* git push
* bundle exec cap production deploy
然后测试网站是否运转正常
如网站报错，则执行以下命令回滚：

* bundle exec cap production deploy:rollback

车行更新
========

1. 修改车行数据
2. 编辑`app/controllers/api/v1/shops_controller.rb`
```ruby
  def server_version
    DateTime.parse '201704260646' #改为最近的日期
  end
```

