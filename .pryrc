def me
  User.find_by mobile: '13652885999'
end

def dadi
  User.dadi.first
end

def zhumadian_dadi
  User.zhumadian_dadi
end

def find_user mobile
  User.find_by mobile: mobile
end

def find_shop name
  Shop.with_deleted.find_by name: name
end

def find_card key
  card = Card.find_by cid: key
  return card if card
  Card.find_by pin: key
end
