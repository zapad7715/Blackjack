require_relative './player'

class Dealer < Player
  def take_card(deck)
    raise "#{@name} пропускает ход." if forbidden_take_card? || size == 3
    super
  end

  private

  def forbidden_take_card?
    score >= 17
  end
end
