require_relative '../config'
class BoardDimensionsGetter
  include Config
  def row_numbers
    "  |#{(1..config['dimensions']).to_a.join('|')}|"
  end

  def row_letters_array
    (1..config['dimensions']).to_a.map { |i| row_letter(index:) }
  end

  def row_letter(index:)
    (index + 'A'.ord).chr
  end
end