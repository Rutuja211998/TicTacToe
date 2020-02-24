#!/bin/bash -x

echo "Welcome to the game TIC-TAC-TOE"

declare -A board

function resetBoard(){
for((i=1;i<=9;i++))
do
	board[$i]=" " 
done
}

function displayBoard(){
echo "| ${board[1]} | ${board[2]} | ${board[3]} |"
echo "| ${board[4]} | ${board[5]} | ${board[6]} |"
echo "| ${board[7]} | ${board[8]} | ${board[9]} |"
}

function toss(){
if (( $((RANDOM%2))==1 ))
then
	playerLetter="X"
else
	playerLetter="O"
fi
}

function checkEmptyCell(){
read -p "Enter Cell Number: " cellNumber

   if [ "${board[$cellNumber]}" == " " ]
   then
      echo "Cell is Empty"
      board[$cellNumber]=$playerLetter
   else
      echo "Cell is not Empty"
   fi
displayBoard
checkEmptyCell
}

resetBoard
displayBoard
toss
checkEmptyCell

