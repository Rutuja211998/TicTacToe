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

function checkForWin(){
	j=0
	for((i=1;i<=3;i++))
	do
		if [[ ( ${board[i+j]} == ${board[i+j+1]} && ${board[i+j+1]} == ${board[i+j+2]} ) ||
			( ${board[i]} == ${board[i+3]} && ${board[i+3]} == ${board[i+6]} ) ||
			( ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} ) ||
			( ${board[3]} == ${board[5]} && ${board[5]} == ${board[7]} ) ]]
		then
			echo "Player Won"
			exit
		fi
		j=$((j+2))
	done
}

resetBoard
displayBoard
toss

while (( count<9 ))
do
	checkEmptyCell
	checkForWin
done
