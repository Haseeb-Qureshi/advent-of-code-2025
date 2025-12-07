DIFFS = [0, 1, -1, 1, -1].permutation(2).uniq

def neighbors(grid, i, j)
  DIFFS.map do |di, dj|
    [i + di, j + dj]
  end.select do |i2, j2|
    in_range?(grid, i2, j2)
  end.map do |i2, j2|
    grid[i2][j2]
  end
end

def in_range?(grid, i, j)
  i.between?(0, grid.length - 1) && j.between?(0, grid[0].length - 1)
end