class Cell
  attr_reader :shot

  def initialize
    @shot = false
  end

  def shoot
    @shot = true
  end

  def shot?
    shot
  end
end
