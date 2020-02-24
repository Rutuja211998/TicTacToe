#!/bin/bash -x

echo "Welcome to the game TIC-TAC-TOE"

declare -A board

resetBoard(){
for((i=1;i<=9;i++))
do
	board[$i]=" " 
done
}

displayBoard(){
echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

function assignLetter(){
if (( $((RANDOM%2))==1 ))
then
	letter='X'
else
	letter='O'
fi
echo your letter is $letter
}

