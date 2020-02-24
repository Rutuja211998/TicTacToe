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

whoPlayFirst(){
	if (( $((RANDOM%2))==1 ))
	then
		player="User"
		assignLetter
		userTurn
	else
		player="Computer"
		assignLetter
		computerTurn
	fi
}

assignLetter(){
	if [ $letter == "X" ]
	then
		letter="O"
	else
		letter="X"
	fi
}

switchTurn(){
	assignLetter
	if [ $player == "User" ]
	then
		player="Computer"
		computerTurn
	else
		player="User"
		userTurn
	fi
}

userTurn(){
	echo "$player Turn"
	read -p "Enter Cell Number: " cellNumber
	checkEmptyCell
	if (( flag==1 ))
	then
		userTurn
	fi
}

computerTurn(){
	echo "$player Turn"
	cellNumber=$((RANDOM%9 + 1))
	echo "random number of Computer:$cellNumber"
	checkEmptyCell
	if (( flag==1 ))
	then
		computerTurn
	fi
}

checkEmptyCell(){
	if [[ ${board[cellNumber]} -ne $cellNumber ]]
	then
		echo "Cell is not Empty...try another cell"
		flag=1
	else
		flag=0
		board[cellNumber]=$letter
		displayBoard
		((cell++))
	fi
}

checkForWin(){
	j=0
	for((i=1;i<=3;i++))
	do
		if [[ ( ${board[i+j]} == ${board[i+j+1]} && ${board[i+j+1]} == ${board[i+j+2]} ) ||
				( ${board[i]} == ${board[i+3]} && ${board[i+3]} == ${board[i+6]} ) ||
				( ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} ) ||
				( ${board[3]} == ${board[5]} && ${board[5]} == ${board[7]} ) ]]
		then
			echo "$player Won"
		exit
		fi
		j=$((j+2))
	done
}

resetBoard
displayBoard
whoPlayFirst

while (( cell<TOTAL_CELL ))
do
	checkForWin
	switchTurn
done

if (( cell == TOTAL_CELL ))
then
	echo "Game Tie"
fi

