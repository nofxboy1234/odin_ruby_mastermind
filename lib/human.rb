class Human < Player
  def choose_mastercode
    gets.chomp.strip.downcase
  end

  def guess_mastercode
    input = gets.chomp.strip.downcase
    input.split('').inject([]) do |array, value|
      array << GuessPeg.new(value, nil, nil)
    end
  end
end
