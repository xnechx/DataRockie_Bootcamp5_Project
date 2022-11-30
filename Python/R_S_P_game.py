from random import sample
def game_start():
    print("------------------Welcome to the game------------------\
        \nyou can choose one of this -> rock, scissors, paper\n\
        \tif you wanna quit, say 'quit'.\n")
    all_bot_hand  = ["rock", "scissors", "paper"]
    win = 0
    lose = 0
    tie = 0
    round = 0
    while True :
        player = input("choose one hand : ").lower()
        bot = sample(all_bot_hand, 1)[0] # bot randoms one hand 
        if player == "quit":
            print(f"win : {win}\t\t tie : {tie}\t\t lose : {lose}") # summary of game
            print("See you later~")
            print("*****************************************")
            break # way to stop game loop
        elif player not in all_bot_hand: # if player dont choose one of game choice
            print("\nPlease choose again.\n")
            print("-------------------------------------------------------------")
        elif player == bot:
            round+=1
            tie+=1
            print(f"\n\t\t\t    round : {round}")
            print(f"player : {player}\nbot : {bot}\nstatus : tie\n")
            print(f"win : {win}\t\t tie : {tie}\t\t lose : {lose}")
            print("-------------------------------------------------------------")
        elif (player == "rock" and bot == "paper") or \
        (player == "scissors" and bot == "rock") or \
        (player == "paper" and bot == "scissors"):
            round+=1
            lose+=1
            print(f"\n\t\t\t    round : {round}")
            print(f"player : {player}\nbot : {bot}\nstatus : you lose~\n")
            print(f"win : {win}\t\t tie : {tie}\t\t lose : {lose}")
            print("-------------------------------------------------------------")
        else : # we have everything (tie, lose) except win, so else is win
            round+=1
            win+=1
            print(f"\n\t\t\t    round : {round}")
            print(f"player : {player}bot : {bot}\nstatus : you win!\n")
            print(f"win : {win}\t\t tie : {tie}\t\t lose : {lose}")
            print("-------------------------------------------------------------")
