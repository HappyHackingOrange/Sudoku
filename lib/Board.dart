import 'dart:collection';

class Board {
  List<List<int>> grid; //empty = 0, else 1-9
  HashSet<RowCol> conflicts;

  Board() {
    grid = new List<List<int>>(9); //fixed length list, add not supported
    for (int r = 0; r < 9; r++) {
      List<int> rowLst = new List<int>(9);
      for (int c = 0; c < 9; c++) { rowLst[c] = 0; }
      grid[r] = rowLst;
    }
    conflicts = new HashSet<RowCol>();
  }

  Board.fromGrid(List<List<int>> newGrid) {
    grid = newGrid;
    conflicts = new HashSet<RowCol>();
  }

  void setCell(int row, int col, int val) {
    grid[row][col] = val;
  }

  HashSet<RowCol> getConflicts() {
    conflicts.clear();
    computeRowConflicts();
    computeColConflicts();
    computeBlockConflicts();
    return conflicts;
  }

  void computeRowConflicts() {
    for (int r = 0; r < 9; r++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int c = 0; c < 9; c++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          conflicts.add(new RowCol(r, c));
          conflicts.add(usedNumToRowCol[newNum]);
        }
        else usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  void computeColConflicts() {
    for (int c = 0; c < 9; c++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int r = 0; r < 9; r++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          conflicts.add(new RowCol(r, c));
          conflicts.add(usedNumToRowCol[newNum]);
        }
        else usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  void computeBlockConflicts() {
    blockConf(0,0); blockConf(0,3); blockConf(0,6);
    blockConf(3,0); blockConf(3,3); blockConf(3,6);
    blockConf(6,0); blockConf(6,3); blockConf(6,6);
  }

  void blockConf(int row, int col) {
    HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
    for (int r = row; r < row + 3; r++) {
      for (int c = col; c < col + 3; c++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          conflicts.add(new RowCol(r, c));
          conflicts.add(usedNumToRowCol[newNum]);
        }
        else usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

}

class RowCol {
  int r;
  int c;
  RowCol(int r, int c) {
    this.r = r;
    this.c = c;
  }

  @override
  String toString() => "r:" + r.toString() + ",c:" + c.toString();

  @override
  // TODO: implement hashCode
  int get hashCode => 10*r + c;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return (this.r == other.r) && (this.c == other.c);
  }
}

void main() {
  Board b1 = new Board.fromGrid([
    [1, 0, 0, 0, 1, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [5, 0, 0, 0, 4, 0, 0, 0, 5] ]);
  print("b1 conflicts: " + b1.getConflicts().toString());

  Board b2 = new Board.fromGrid([
    [1, 0, 0, 0, 0, 0, 0, 0, 6],
    [0, 0, 0, 0, 0, 0, 0, 0, 7],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [2, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 9],
    [1, 0, 0, 0, 0, 0, 0, 0, 7] ]);
  print("b2 conflicts: " + b2.getConflicts().toString());

  Board b3 = new Board.fromGrid([
    [9, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 9, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 9, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 3, 0],
    [0, 0, 0, 0, 0, 0, 3, 0, 1] ]);
  print("b3 conflicts: " + b3.getConflicts().toString());

  Board b4 = new Board.fromGrid([
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [4, 0, 0, 0, 0, 0, 0, 0, 0],
    [5, 0, 0, 0, 0, 0, 0, 0, 0],
    [6, 0, 0, 0, 0, 0, 0, 0, 0],
    [7, 0, 0, 0, 0, 0, 1, 9, 8],
    [8, 0, 0, 0, 0, 0, 4, 2, 6],
    [9, 0, 0, 0, 0, 0, 5, 7, 3] ]);
  print("b4 conflicts: " + b4.getConflicts().toString());

  Board b5 = new Board();
  print(b5.grid[8][8]);
  b5.setCell(8, 8, 9);
  print(b5.grid[8][8]);
}