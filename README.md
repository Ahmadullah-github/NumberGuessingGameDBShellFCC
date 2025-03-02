# Number Guessing Game

## Description

This is a Bash script that implements a number guessing game as part of freeCodeCamp's Relational Databases certification. The game generates a random number between 1 and 1000, and the player must guess it. The script stores user data in a PostgreSQL database, tracking the number of games played and the best game (fewest guesses).

## Features

- Generates a random number between 1 and 1000.
- Prompts the user to enter their username.
- If the user is new, they are welcomed and added to the database.
- If the user is returning, their previous stats (games played and best game) are displayed.
- The script validates input to ensure only integers are accepted.
- Tracks the number of guesses and updates the database accordingly.
- Stores game records in a PostgreSQL database.

## Database Schema

The PostgreSQL database `number_guess` consists of two tables:

### `users` Table

| Column   | Type   | Constraints      |
| -------- | ------ | ---------------- |
| user\_id | SERIAL | PRIMARY KEY      |
| username | TEXT   | UNIQUE, NOT NULL |

### `guesses` Table

| Column        | Type | Constraints                |
| ------------- | ---- | -------------------------- |
| user\_id      | INT  | REFERENCES users(user\_id) |
| games\_played | INT  | NOT NULL                   |
| best\_game    | INT  | NOT NULL                   |

## Installation and Setup

### Prerequisites

- Bash (Unix-based system or Git Bash on Windows)
- PostgreSQL installed and running
- Gitpod or any Bash-compatible terminal

### Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/number-guessing-game.git
   cd number-guessing-game
   ```
2. Ensure PostgreSQL is running and create the database:
   ```bash
   psql --username=your_postgres_user --dbname=postgres -c "CREATE DATABASE number_guess;"
   ```
3. Connect to the database and create the required tables:
   ```bash
   psql --username=your_postgres_user --dbname=number_guess -f schema.sql
   ```
4. Run the script:
   ```bash
   ./number_guess.sh
   ```

## How to Play

1. Enter your username when prompted.
2. If you're a new player, you’ll be welcomed and added to the database.
3. If you're a returning player, your past records will be displayed.
4. Try to guess the secret number based on hints (higher/lower).
5. The script will track your number of guesses and update the database accordingly.
6. At the end, you'll see how many attempts it took to guess the correct number.

## Example Output

```
Enter your username:
JohnDoe
Welcome back, JohnDoe! You have played 3 games, and your best game took 5 guesses.
Guess the secret number between 1 and 1000:
500
It's lower than that, guess again:
250
It's higher than that, guess again:
300
You guessed it in 3 tries. The secret number was 300. Nice job!
```

## Author

Developed by Ahmadullah Ahmadi as part of freeCodeCamp's Relational Databases certification.

## License

This project is open-source and available under the MIT License.


