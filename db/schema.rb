# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170111153459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_brands", force: :cascade do |t|
    t.string   "en_name"
    t.string   "cn_name"
    t.string   "shor_name"
    t.string   "img_url"
    t.string   "manufacture"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "initial_letter"
  end

  create_table "car_config", id: :bigint, force: :cascade do |t|
    t.string "首字母",                  limit: 50
    t.string "品牌",                   limit: 50
    t.string "车系",                   limit: 50
    t.string "销售状态",                 limit: 50
    t.string "车型名称",                 limit: 100
    t.string "年款",                   limit: 50
    t.string "厂商指导价(元)",             limit: 50
    t.string "排量",                   limit: 50
    t.string "厂商",                   limit: 50
    t.string "级别",                   limit: 50
    t.string "发动机",                  limit: 50
    t.string "变速箱",                  limit: 50
    t.string "长*宽*高(mm)",            limit: 50
    t.string "车身结构",                 limit: 50
    t.string "最高车速(km/h)",           limit: 50
    t.string "官方0-100km/h加速(s)",     limit: 50
    t.string "实测0-100km/h加速(s)",     limit: 50
    t.string "实测100-0km/h制动(m)",     limit: 50
    t.string "实测油耗(L/100km)",        limit: 50
    t.string "工信部综合油耗(L/100km)",     limit: 50
    t.string "实测离地间隙(mm)",           limit: 50
    t.string "整车质保",                 limit: 50
    t.string "长度(mm)",               limit: 50
    t.string "宽度(mm)",               limit: 50
    t.string "高度(mm)",               limit: 50
    t.string "轴距(mm)",               limit: 50
    t.string "前轮距(mm)",              limit: 50
    t.string "后轮距(mm)",              limit: 50
    t.string "最小离地间隙(mm)",           limit: 50
    t.string "整备质量(kg)",             limit: 50
    t.string "车门数(个)",               limit: 50
    t.string "座位数(个)",               limit: 50
    t.string "油箱容积(L)",              limit: 50
    t.string "行李厢容积(L)",             limit: 50
    t.string "发动机型号",                limit: 50
    t.string "排量(mL)",               limit: 50
    t.string "排量(L)",                limit: 50
    t.string "进气形式",                 limit: 50
    t.string "气缸排列形式",               limit: 50
    t.string "气缸数(个)",               limit: 50
    t.string "每缸气门数(个)",             limit: 50
    t.string "压缩比",                  limit: 50
    t.string "配气机构",                 limit: 50
    t.string "缸径(mm)",               limit: 50
    t.string "行程(mm)",               limit: 50
    t.string "最大马力(Ps)",             limit: 50
    t.string "最大功率(kW)",             limit: 50
    t.string "最大功率转速(rpm)",          limit: 50
    t.string "最大扭矩(N·m)",            limit: 50
    t.string "最大扭矩转速(rpm)",          limit: 50
    t.string "发动机特有技术",              limit: 50
    t.string "燃料形式",                 limit: 50
    t.string "燃油标号",                 limit: 50
    t.string "供油方式",                 limit: 50
    t.string "缸盖材料",                 limit: 50
    t.string "缸体材料",                 limit: 50
    t.string "环保标准",                 limit: 50
    t.string "简称",                   limit: 50
    t.string "挡位个数",                 limit: 50
    t.string "变速箱类型",                limit: 50
    t.string "驱动方式",                 limit: 50
    t.string "四驱形式",                 limit: 50
    t.string "中央差速器结构",              limit: 50
    t.string "前悬架类型",                limit: 50
    t.string "后悬架类型",                limit: 50
    t.string "助力类型",                 limit: 50
    t.string "车体结构",                 limit: 50
    t.string "前制动器类型",               limit: 50
    t.string "后制动器类型",               limit: 50
    t.string "驻车制动类型",               limit: 50
    t.string "前轮胎规格",                limit: 50
    t.string "后轮胎规格",                limit: 50
    t.string "备胎规格",                 limit: 50
    t.string "主/副驾驶座安全气囊",           limit: 50
    t.string "前/后排侧气囊",              limit: 50
    t.string "前/后排头部气囊(气帘)",         limit: 50
    t.string "膝部气囊",                 limit: 50
    t.string "胎压监测装置",               limit: 50
    t.string "零胎压继续行驶",              limit: 50
    t.string "安全带未系提示",              limit: 50
    t.string "ISOFIX儿童座椅接口",         limit: 50
    t.string "发动机电子防盗",              limit: 50
    t.string "车内中控锁",                limit: 50
    t.string "遥控钥匙",                 limit: 50
    t.string "无钥匙启动系统",              limit: 50
    t.string "无钥匙进入系统",              limit: 50
    t.string "ABS防抱死",               limit: 50
    t.string "制动力分配(EBD/CBC等)",      limit: 50
    t.string "刹车辅助(EBA/BAS/BA等)",    limit: 50
    t.string "牵引力控制(ASR/TCS/TRC等)",  limit: 50
    t.string "车身稳定控制(ESC/ESP/DSC等)", limit: 50
    t.string "上坡辅助",                 limit: 50
    t.string "自动驻车",                 limit: 50
    t.string "陡坡缓降",                 limit: 50
    t.string "可变悬架",                 limit: 50
    t.string "空气悬架",                 limit: 50
    t.string "可变转向比",                limit: 50
    t.string "前桥限滑差速器/差速锁",          limit: 50
    t.string "中央差速器锁止功能",            limit: 50
    t.string "后桥限滑差速器/差速锁",          limit: 50
    t.string "电动天窗",                 limit: 50
    t.string "全景天窗",                 limit: 50
    t.string "运动外观套件",               limit: 50
    t.string "铝合金轮圈",                limit: 50
    t.string "电动吸合门",                limit: 50
    t.string "侧滑门",                  limit: 50
    t.string "电动后备厢",                limit: 50
    t.string "感应后备厢",                limit: 50
    t.string "车顶行李架",                limit: 50
    t.string "真皮方向盘",                limit: 50
    t.string "方向盘调节",                limit: 50
    t.string "方向盘电动调节",              limit: 50
    t.string "多功能方向盘",               limit: 50
    t.string "方向盘换挡",                limit: 50
    t.string "方向盘加热",                limit: 50
    t.string "方向盘记忆",                limit: 50
    t.string "定速巡航",                 limit: 50
    t.string "前/后驻车雷达",              limit: 50
    t.string "倒车视频影像",               limit: 50
    t.string "行车电脑显示屏",              limit: 50
    t.string "全液晶仪表盘",               limit: 50
    t.string "HUD抬头数字显示",            limit: 50
    t.string "座椅材质",                 limit: 50
    t.string "运动风格座椅",               limit: 50
    t.string "座椅高低调节",               limit: 50
    t.string "腰部支撑调节",               limit: 50
    t.string "肩部支撑调节",               limit: 50
    t.string "主/副驾驶座电动调节",           limit: 50
    t.string "第二排靠背角度调节",            limit: 50
    t.string "第二排座椅移动",              limit: 50
    t.string "后排座椅电动调节",             limit: 50
    t.string "电动座椅记忆",               limit: 50
    t.string "前/后排座椅加热",             limit: 50
    t.string "前/后排座椅通风",             limit: 50
    t.string "前/后排座椅按摩",             limit: 50
    t.string "第三排座椅",                limit: 50
    t.string "后排座椅放倒方式",             limit: 50
    t.string "前/后中央扶手",              limit: 50
    t.string "后排杯架",                 limit: 50
    t.string "GPS导航系统",              limit: 50
    t.string "定位互动服务",               limit: 50
    t.string "中控台彩色大屏",              limit: 50
    t.string "蓝牙/车载电话",              limit: 50
    t.string "车载电视",                 limit: 50
    t.string "后排液晶屏",                limit: 50
    t.string "220V/230V电源",          limit: 50
    t.string "外接音源接口",               limit: 50
    t.string "CD支持MP3/WMA",          limit: 50
    t.string "多媒体系统",                limit: 50
    t.string "扬声器品牌",                limit: 50
    t.string "扬声器数量",                limit: 50
    t.string "近光灯",                  limit: 50
    t.string "远光灯",                  limit: 50
    t.string "日间行车灯",                limit: 50
    t.string "自适应远近光",               limit: 50
    t.string "自动头灯",                 limit: 50
    t.string "转向辅助灯",                limit: 50
    t.string "转向头灯",                 limit: 50
    t.string "前雾灯",                  limit: 50
    t.string "大灯高度可调",               limit: 50
    t.string "大灯清洗装置",               limit: 50
    t.string "车内氛围灯",                limit: 50
    t.string "前/后电动车窗",              limit: 50
    t.string "车窗防夹手功能",              limit: 50
    t.string "防紫外线/隔热玻璃",            limit: 50
    t.string "后视镜电动调节",              limit: 50
    t.string "后视镜加热",                limit: 50
    t.string "内/外后视镜自动防眩目",          limit: 50
    t.string "后视镜电动折叠",              limit: 50
    t.string "后视镜记忆",                limit: 50
    t.string "后风挡遮阳帘",               limit: 50
    t.string "后排侧遮阳帘",               limit: 50
    t.string "后排侧隐私玻璃",              limit: 50
    t.string "遮阳板化妆镜",               limit: 50
    t.string "后雨刷",                  limit: 50
    t.string "感应雨刷",                 limit: 50
    t.string "空调控制方式",               limit: 50
    t.string "后排独立空调",               limit: 50
    t.string "后座出风口",                limit: 50
    t.string "温度分区控制",               limit: 50
    t.string "车内空气调节/花粉过滤",          limit: 50
    t.string "车载冰箱",                 limit: 50
    t.string "自动泊车入位",               limit: 50
    t.string "发动机启停技术",              limit: 50
    t.string "并线辅助",                 limit: 50
    t.string "车道偏离预警系统",             limit: 50
    t.string "主动刹车/主动安全系统",          limit: 50
    t.string "整体主动转向系统",             limit: 50
    t.string "夜视系统",                 limit: 50
    t.string "中控液晶屏分屏显示",            limit: 50
    t.string "自适应巡航",                limit: 50
    t.string "全景摄像头",                limit: 50
    t.text   "外观颜色"
    t.text   "外观颜色码"
    t.text   "内饰颜色"
    t.text   "内饰颜色码"
    t.string "后排车门开启方式",             limit: 50
    t.string "货箱尺寸(mm)",             limit: 50
    t.string "最大载重质量(kg)",           limit: 50
    t.string "电动机总功率(kW)",           limit: 50
    t.string "电动机总扭矩(N·m)",          limit: 50
    t.string "前电动机最大功率(kW)",         limit: 50
    t.string "前电动机最大扭矩(N·m)",        limit: 50
    t.string "后电动机最大功率(kW)",         limit: 50
    t.string "后电动机最大扭矩(N·m)",        limit: 50
    t.string "工信部续航里程(km)",          limit: 50
    t.string "电池容量(kWh)",            limit: 50
    t.string "电池组质保",                limit: 50
    t.string "电池充电时间",               limit: 50
    t.string "充电桩价格",                limit: 50
  end

  create_table "car_models", force: :cascade do |t|
    t.integer  "car_brand_id"
    t.string   "cn_name"
    t.string   "en_name"
    t.string   "initial_letter"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cards", id: false, force: :cascade do |t|
    t.integer  "id"
    t.string   "pin"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "cid"
    t.integer  "status",     default: 0
  end

  create_table "cars", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "licensed_id"
    t.integer  "status"
    t.date     "joined_at"
    t.date     "visited_at"
    t.integer  "user_id"
    t.string   "city"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "valid_at"
    t.index ["licensed_id"], name: "index_cars_on_licensed_id", unique: true, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "env_star"
    t.integer  "service_star"
    t.integer  "clean_star"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "deal_id"
  end

  create_table "deals", force: :cascade do |t|
    t.integer  "car_id"
    t.integer  "shop_id"
    t.datetime "visited_at"
    t.datetime "cleaned_at"
    t.integer  "status"
    t.string   "comments"
    t.datetime "commented_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  create_table "evaluates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.integer  "service_score",     limit: 2, default: 0
    t.integer  "quality_score",     limit: 2, default: 0
    t.integer  "environment_score", limit: 2, default: 0
    t.text     "comment"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["shop_id"], name: "index_evaluates_on_shop_id", using: :btree
    t.index ["user_id"], name: "index_evaluates_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "state"
    t.integer  "payment_gateway"
    t.integer  "trade_no"
    t.float    "price"
    t.integer  "quantity"
    t.float    "distcount"
    t.string   "subject"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "platform"
    t.float    "total_amount"
    t.string   "body"
    t.datetime "finished_at"
    t.datetime "canceled_at"
    t.integer  "status"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone"
    t.string   "pin"
    t.boolean  "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string    "name"
    t.string    "phone"
    t.string    "city"
    t.integer   "star"
    t.string    "category"
    t.string    "address"
    t.daterange "duration"
    t.integer   "status"
    t.string    "profile"
    t.string    "services"
    t.string    "sale_content"
    t.string    "province"
    t.string    "county"
    t.string    "position",                  array: true
    t.datetime  "created_at",   null: false
    t.datetime  "updated_at",   null: false
    t.string    "image"
    t.integer   "user_id"
    t.string    "openning"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "mobile"
    t.string   "access_token"
    t.string   "pin"
    t.boolean  "verified"
    t.string   "authentication_token"
    t.integer  "roles",                  default: 0
    t.string   "invitation_token"
    t.integer  "invited_by"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
