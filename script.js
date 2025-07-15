import java.util.*;

public class TicTacToe {
    static char[][] board = {{' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}};
    static char currentPlayer = 'X';

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            printBoard();
            System.out.println("Player " + currentPlayer + ", enter row and column (0-2): ");
            int row = scanner.nextInt();
            int col = scanner.nextInt();

            if (board[row][col] != ' ') {
                System.out.println("Cell already taken. Try again.");
                continue;
            }

            board[row][col] = currentPlayer;

            if (checkWinner()) {
                printBoard();
                System.out.println("Player " + currentPlayer + " wins!");
                break;
            } else if (isBoardFull()) {
                printBoard();
                System.out.println("It's a draw!");
                break;
            }

            currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
        scanner.close();
    }

    static void printBoard() {
        for (char[] row : board) {
            System.out.println(Arrays.toString(row));
        }
    }

    static boolean checkWinner() {
        for (int i = 0; i < 3; i++) {
            if (board[i][0] == currentPlayer &&
                board[i][1] == currentPlayer &&
                board[i][2] == currentPlayer) return true;
            if (board[0][i] == currentPlayer &&
                board[1][i] == currentPlayer &&
                board[2][i] == currentPlayer) return true;
        }
        return board[0][0] == currentPlayer &&
               board[1][1] == currentPlayer &&
               board[2][2] == currentPlayer
            || board[0][2] == currentPlayer &&
               board[1][1] == currentPlayer &&
               board[2][0] == currentPlayer;
    }

    static boolean isBoardFull() {
        for (char[] row : board)
            for (char cell : row)
                if (cell == ' ') return false;
        return true;
    }
}