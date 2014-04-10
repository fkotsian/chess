# SteppingPiece.rb
load "piece.rb"

class SteppingPiece < Piece

  def moves
    doable_moves = []
    self.get_diffs.each do |diff|
      current_pos = self.pos

      new_pos = get_new_pos(current_pos, diff)

      unless out_of_bounds?(new_pos)
        if self.board.empty?(new_pos)
          doable_moves << new_pos
          # return new_pos
        else  # board[pos] is not empty
          piece_at_pos = self.board.at(new_pos)
          if piece_at_pos.color != self.color && !piece_at_pos.is_a?(King) # King can't be adjacent to King
              doable_moves << new_pos
            # return new_pos
          end
        end
      end
    end
    doable_moves
  end

  def get_diffs
  end
end

class King < SteppingPiece

  def get_diffs
    [
    [1,   1],
    [1,  -1],
    [-1,  1],
    [-1, -1],
    [ 1,  0],
    [-1,  0],
    [ 0,  1],
    [ 0, -1]
           ]
  end
end

class Knight < SteppingPiece

  def get_diffs
    [
    [2,    1],
    [2,   -1],
    [1,    2],
    [1,   -2],
    [-1,   2],
    [-1,  -2],
    [-2,   1],
    [-2,  -1]
            ]
  end
end