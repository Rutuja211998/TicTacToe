#!/bin/bash -x

echo "Welcome to Tic-Tac-Toe Game"

declare -a board

TOTAL_CELL=9

cell=0
letter="O"
flag=0
flag1=0

resetBoard(){
	for((i=1;i<=9;i++))
	do
   	board[i]=$i
	done
}

displayBoard(){
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
	echo "$player"
	read -p "Enter Cell Number: " cellNumber
	checkEmptyCell
	if (( flag==1 ))
	then
		userTurn
	fi
}

computerTurn(){
	echo "$player"
	checkSelfWin
	if (( flag==1 ))
	then
		computerTurn
	fi
}

checkSelfWin(){
	j=0
	for((i=1;i<=3;i++))
	do
		if [[ ${board[i+j]} == $letter && ${board[i+j+1]} == $letter ]]
		then
			cellNumber=$((i+j+2))
			checkEmptyCell
			break
		elif [[ ${board[i+j]} == $letter && ${board[i+j+2]} == $letter ]]
		then
			cellNumber=$((i+j+1))
			checkEmptyCell
			break
		elif [[ ${board[i+j+1]} == $letter && ${board[i+j+2]} == $letter ]]
		then
			cellNumber=$((i+j))
			checkEmptyCell
			break
		elif [[ ${board[i]} == $letter && ${board[i+3]} == $letter ]]
		then
			cellNumber=$((i+6))
			checkEmptyCell
			break
		elif [[ ${board[i]} == $letter && ${board[i+6]} == $letter ]]
		then
			cellNumber=$((i+3))
			checkEmptyCell
			break
		elif [[ ${board[i+3]} == $letter && ${board[i+6]} == $letter ]]
		then
			cellNumber=$i
			checkEmptyCell
			break
		fi
		j=$((j+2))
	done
	checkForWin
	checkSelfWinDiagonal
}

checkSelfWinDiagonal(){
	if [[ ${board[1]} == $letter && ${board[5]} == $letter ]]
	then
		cellNumber=9
		checkEmptyCell
	elif [[ ${board[3]} == $letter && ${board[5]} == $letter ]]
	then
		cellNumber=7
		checkEmptyCell
	elif [[ ${board[1]} == $letter && ${board[9]} == $letter ]]
	then
		cellNumber=5
		checkEmptyCell
	elif [[ ${board[3]} == $letter && ${board[7]} == $letter ]]
	then
		cellNumber=5
		checkEmptyCell
	elif [[ ${board[5]} == $letter && ${board[9]} == $letter ]]
	then
		cellNumber=1
		checkEmptyCell
	elif [[ ${board[7]} == $letter && ${board[5]} == $letter ]]
	then
		cellNumber=3
		checkEmptyCell
	else
		cellNumber=$((RANDOM%9+1))
		echo "random position entered by computer is : $cellNumber"
		checkEmptyCell
	fi
}

checkEmptyCell(){
	if [[ ${board[cellNumber]} -ne $cellNumber ]]
	then
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
	checkForWin
	echo "Game Tie"
fi


