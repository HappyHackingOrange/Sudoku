import 'dart:collection';

class Conflict {

  static HashSet<RowCol> getConflicts(List<List<int>> grid) {
    HashSet<RowCol> result = new HashSet<RowCol>();
    computeRowConflicts(grid, result);
    computeColConflicts(grid, result);
    computeBlockConflicts(grid, result);
    return result;
  }

  static void computeRowConflicts(List<List<int>> grid, HashSet<RowCol> res) {
    for (int r = 0; r < 9; r++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int c = 0; c < 9; c++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
        }
        else usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  static void computeColConflicts(List<List<int>> grid, HashSet<RowCol> res) {
    for (int c = 0; c < 9; c++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int r = 0; r < 9; r++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
        }
        else usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  static void computeBlockConflicts(List<List<int>> grid, HashSet<RowCol> res) {
    blockConf(0,0, grid, res); blockConf(0,3, grid, res); blockConf(0,6, grid, res);
    blockConf(3,0, grid, res); blockConf(3,3, grid, res); blockConf(3,6, grid, res);
    blockConf(6,0, grid, res); blockConf(6,3, grid, res); blockConf(6,6, grid, res);
  }
  static void blockConf(int row, int col, List<List<int>> grid, HashSet<RowCol> res) {
    HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
    for (int r = row; r < row + 3; r++) {
      for (int c = col; c < col + 3; c++) {
        int newNum = grid[r][c];
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
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
  List<List<int>> g1 = [
    [1, 0, 0, 0, 1, 0, 5, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [9, 0, 4, 0, 0, 0, 0, 0, 9] ];
  print("g1 conflicts: " + Conflict.getConflicts(g1).toString());

  List<List<int>> g2 = [
    [1, 0, 0, 0, 0, 0, 0, 0, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 5],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [4, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0, 9] ];
  print("g2 conflicts: " + Conflict.getConflicts(g2).toString());

  List<List<int>> g3 = [
    [9, 3, 0, 0, 0, 0, 0, 0, 0],
    [0, 9, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 9, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 2],
    [0, 0, 0, 0, 0, 0, 0, 2, 0],
    [0, 0, 0, 0, 0, 0, 1, 0, 1] ];
  print("g3 conflicts: " + Conflict.getConflicts(g3).toString());

  List<List<int>> g4 = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [4, 0, 0, 0, 0, 0, 0, 0, 0],
    [5, 0, 0, 0, 0, 0, 0, 0, 0],
    [6, 0, 0, 0, 0, 0, 0, 0, 0],
    [7, 0, 0, 0, 0, 0, 1, 9, 8],
    [8, 0, 0, 0, 0, 0, 4, 2, 6],
    [9, 0, 0, 0, 0, 0, 5, 7, 3] ];
  print("g4 conflicts: " + Conflict.getConflicts(g4).toString());

}