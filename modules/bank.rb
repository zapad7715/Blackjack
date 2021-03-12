module Bank
  def give_money!(amount)
    raise 'Денег нет, но вы держитесь!' if @bank < amount
    @bank -= amount
    amount
  end

  def take_money(amount)
    @bank += amount
  end
end
