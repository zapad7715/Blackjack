require_relative './modules/show'

class Game
  ACTIONS = { 1 => :dealer_hit, 2 => :user_hit, 3 => :open_cards }.freeze
  BANK = 100
  BET = 10

  include Show

  def initialize
    @dealer = Dealer.new('Дилер', BANK)
    @user = create_user
    @players = [@user, @dealer]
    @deck = Deck.new
    @bets = 0
    greeting(@user)
  end

  def start
    start_menu(@user)
    choise = gets.chomp
    case choise
    when 'y'
      new_con
      start_con
    else
      puts 'Выход.'
      exit
    end
  end

  private

  def make_bet(bet = BET)
    @players.each { |player| @bets += player.give_money!(bet) }
  rescue RuntimeError => e
    show_message(e.message)
  end

  def cleanup
    @bets = 0
    @deck = Deck.new
    @players.each(&:cleanup_cards)
  end

  def choice_actions(player)
    show_actions(player)
    show_choice(choice = gets.chomp.to_i)
    send(ACTIONS[choice])
  end

  def con
    open_cards if @user.size == 3 && @dealer.size == 3
    show_cards(@user)
    hide_cards(@dealer)
    choice_actions(@user)
  rescue RuntimeError => e
    show_message(e.message)
    con
  rescue TypeError
    choice_actions(@user)
  end

  def create_user
    puts 'Введите ваше имя:'
    Player.new(gets.chomp.capitalize, BANK)
  rescue RuntimeError => e
    show_message(e.message)
    retry
  end

  def dealer_hit
    hit(@dealer)
    con
  end

  def determine_winner
    return @user if @dealer.score > 21
    return @dealer if @user.score > 21
    @dealer.score > @user.score ? @dealer : @user
  end

  def revert_bets
    @user.take_money(BET)
    @dealer.take_money(BET)
    @bets = 0
  end

  def hit(player)
    puts "Ход #{player}"
    player.take_card(@deck)
    puts "#{player} взял карту."
    line
  end

  def open_cards
    end_con
    @players.each { |player| show_cards(player) }
    if @player.score == @dealer.score
      show_dead_heat
      revert_bets
    else
      winner = determine_winner
      show_winner(winner)
      winner.take_money(@bets)
    end
    start
  end

  def start_con
    cleanup
    2.times do
      @players.each { |player| player.take_card(@deck) }
    end
    make_bet(BET)
    con
  end

  def user_hit
    if @user.cards.size < 3
      hit(@user)
    else
      puts 'У вас уже 3 карты.'
      choice_actions(@user)
    end
    dealer_hit
  end
end
