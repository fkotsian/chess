load "piece.rb"

# SlidingPiece.rb

class SlidingPiece < Piece

  def moves
    #returns all moves regardless of board boundaries
    valid_pos = []

    self.move_dirs.each do |diff|
      current_pos = self.pos

      until out_of_bounds?( current_pos )
        new_pos = get_new_pos(current_pos, diff)

        if out_of_bounds?( new_pos )
          break
        # look if there is a piece there
        elsif self.board.empty?( new_pos )
          valid_pos << new_pos
        else  # board[pos] is not empty
          piece_at_pos = self.board.at( new_pos )
          if piece_at_pos.color != self.color
            valid_pos << new_pos
          end

          # Since found piece, need to break out of until loop
          break
        end

        current_pos = new_pos
      end
    end
    valid_pos
  end

end

class Bishop < SlidingPiece

  def move_dirs
    [
      [1,   1],
      [1,  -1],
      [-1,  1],
      [-1, -1]
    ]
  end
end

class Rook < SlidingPiece

  def move_dirs
    [
      [1,  0],  [0,  1],
      [-1, 0],  [0, -1]
    ]
  end
end


class Queen < SlidingPiece

  def move_dirs
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