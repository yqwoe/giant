class DiffService
  def self.compare src, dst
    count = 0
    src.size.times do |i|
      if dst[i]
        count += 1 if src[i] == dst[i]
      end
    end
    count
  end
end
