module Show
  def greeting(player)
    line
    puts "#{player}, добро пожаловать в игру Blackjack!"
    line
  end

  def end_con
    puts 'Кон окончен.'
    line
  end

  def hide_cards(player)
    puts "Карты #{player}:"
    player.each { puts 'Карта: *. Очков: *' }
    line
  end

  def line
    puts '========================================================================='
  end

  def new_con
    puts ''
    puts 'Начинаем новый кон.'
    line
  end

  def show_actions(player)
    puts 'Выберите нужное действие:'
    puts '1 – Пропустить ход.'
    puts '2 – Взять еще карту.' if player.size == 2
    puts '3 – Открыть карты.'
    line
  end

  def show_card(card)
    puts "Карта: #{card}. Очков: #{card.value}"
  end

  def show_cards(player)
    puts "Карты #{player}:"
    player.each { |card| show_card(card) }
    total(player)
    line
  end

  def show_choice(choice)
    puts ''
    2.times { line }
    puts "Вы выбрали #{choice}."
    line
  end

  def start_menu(player)
    puts "Ваш банк составляет #{player.bank} долларов. Ставка за раунд 10 долларов."
    puts 'Начать новый кон? y/n?'
    line
  end

  def show_message(message)
    puts message
    line
  end

  def show_winner(winner)
    puts "Победитель: #{winner}!"
  end

  def show_dead_heat
    puts "Ничья!"
  end

  def total(player)
    puts "Всего очков: #{player.score}"
  end
end
