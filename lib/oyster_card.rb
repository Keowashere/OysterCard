class OysterCard
  attr_reader :balance, :limit, :check, :in_journey, :entry_station
  LIMIT = 90
  MIN = 1


  def initialize
    @balance = 0
    @limit = LIMIT
  end

  def top_up(amount)
    fail "Error, Maximum card limit of £#{@limit}" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey
     !!entry_station
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    fail "Error, Insufficient Funds" if @balance < MIN
    @in_journey = true
  end

  def touch_out
    deduct(MIN)
    @entry_station = nil
  end
  private
  def deduct(amount)
    @balance -= amount
  end

end
