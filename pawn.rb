load "stepping_piece.rb"
# Pawn.rb

#DO THIS LAST CUZ NED SED SO
class Pawn < Piece
  attr_accessor :first_move

  def initialize(pos, board, color, first_move = true)
    super(pos, board, color)
    @first_move = first_move
  end

  def moves
    doable_moves = []
    attacking = false

    attack_diffs = get_valid_attack_diffs

    # get the right diffs to attack and then set attacking to true
    if not attack_diffs.empty?
      attacking = true
      diffs = attack_diffs
    else
      diffs = move_diffs
      # account for weirdo move diffs
      if self.color == :black
        diffs = swap_colors(diffs)
      end
    end

    # Check if each new_pos is valid
    diffs.each do |diff|
      current_pos = self.pos
      new_pos = get_new_pos(current_pos, diff)

      unless out_of_bounds?(new_pos)
        if !self.board.empty?(new_pos) && attacking
          piece_at_pos = self.board.at(new_pos)
          if piece_at_pos.color != self.color
              doable_moves << new_pos
          end
        elsif self.board.empty?(new_pos)
          doable_moves << new_pos
          # return new_pos
        end
      end
    end
    doable_moves

  end

  def move_diffs
    if self.first_move
      [
        [-2, 0],
        [-1, 0]
      ]
    else
      [
        [-1, 0]
      ]
    end
  end

  def swap_colors(diffs)
    diffs.each do |diff|
      diff.map! { |coor| coor *= -1}
    end
  end

  def get_valid_attack_diffs
    valid_attack_diffs = []
    self.attack_diffs.each do |attack_diff|
      new_pos = get_new_pos(self.pos, attack_diff)
      if !self.board.empty?(new_pos) && self.board.at(new_pos).color != self.color
        valid_attack_diffs << attack_diff
      end
    end
    valid_attack_diffs
  end

  def attack_diffs
    if self.color == :black
      [
        [ 1,  1],
        [ 1, -1]
      ]
    else
      [
        [-1,  1],
        [-1, -1]
      ]
    end
  end

end