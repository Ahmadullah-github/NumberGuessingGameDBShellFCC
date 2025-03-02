#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
#function which provide guesses for users
GUESS_FUNCTION(){
  secret_number=$(( RANDOM % 1000 + 1 ))
  number_of_tries=0
  echo -e "\nGuess the secret number between 1 and 1000:"
  read GUESSED_NUMBER
  while true
  do
    if [[ $GUESSED_NUMBER =~ ^[0-9]+$ ]]
    then 
      while true 
      do 
        ((number_of_tries++))
        if [[ $secret_number > $GUESSED_NUMBER ]]
        then 
          echo "It's higher than that, guess again:"
          read GUESSED_NUMBER
        elif [[ $secret_number < $GUESSED_NUMBER ]]
        then  
          echo "It's lower than that, guess again:"
          read GUESSED_NUMBER
        elif [[ $secret_number == $GUESSED_NUMBER ]] 
        then
          echo "You guessed it in $number_of_tries tries. The secret number was $secret_number. Nice job!"
          SECRET_NUMBER=$secret_number
          NUMBER_OF_TRIES=$number_of_tries
          break
        fi
      done
      break
    else
      echo "That is not an integer, guess again:"
      read GUESSED_NUMBER
    fi
  done 
}


echo "Enter your username:"
read USERNAME

checkUSER_IN_DB=$($PSQL "select user_id from users where username = '$USERNAME'")

if [[ -z $checkUSER_IN_DB ]] 
then 
  addUSER_IN_DB=$($PSQL "insert into users (username) values ('$USERNAME')" )
  user_id_FROM_DB=$($PSQL "select user_id from users where username = '$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  GUESS_FUNCTION
  #echo "$SECRET_NUMBER"
  #echo -e "\n$NUMBER_OF_TRIES"
  addUSERGUESS_IN_DB=$($PSQL "insert into guesses (user_id, games_played, best_game) values ($user_id_FROM_DB,1, $NUMBER_OF_TRIES)")
else 
  user_id_FROM_DB=$checkUSER_IN_DB
  games_played_FROM_DB=$($PSQL "select games_played from guesses where user_id = $user_id_FROM_DB")
  best_game_FROM_DB=$($PSQL "select best_game from guesses where user_id = $user_id_FROM_DB")
  echo "Welcome back, $USERNAME! You have played $games_played_FROM_DB games, and your best game took $best_game_FROM_DB guesses."
  GUESS_FUNCTION
  ((games_played_FROM_DB++))
  games_played_UPDATE_DB=$($PSQL "update guesses set games_played = $games_played_FROM_DB where user_id = $user_id_FROM_DB")
  best_game_UPDATE_DB=$($PSQL "update guesses set best_game = $NUMBER_OF_TRIES where user_id = $user_id_FROM_DB")
fi
#done in three days in 02/03/2025



    