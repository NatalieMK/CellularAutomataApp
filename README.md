# Cellular Automata App
Simulates cellular automata patterns according to rules of Wolfram Alpha. 

## What can I do with this?
This app is designed with the usage of *visual patterns* generated through the rules of automata. The configuration screen allows for users to change the colors used, the pattern followed, and quantity of iterations represented by the generated image. 

The **Primary Color** controls the color of the "true" cells, or those represented by a 1 in binary notation.
The **Secondary Color** controls the color of the "false" cells, or those represented by a 0 in binary notation.

The **Number of Rounds** controls how many iterations of the pattern are shown. 

## Rule 30

Rule 30 is an elementary cellular automata, in which the state of a cell is determined by its linear neighbors in accordance to the following:

Left ^ (Center || Right)


![image](https://user-images.githubusercontent.com/46231960/149709942-47e411c8-0cba-4f7f-90f7-d93cd9b6df1e.png)

## Rule 90

Rule 90 is an elementary cellular automata, in which the state of a cell is determined by its linear neighbors in accordance to the following:

Left ^ Right

![image](https://user-images.githubusercontent.com/46231960/149710063-94d9e866-a58b-4079-bd76-6116b25c5a82.png)

## Rule 110

Rule 110 is an elementary cellular automata, in which the state of a cell is determined by its linear neighbors in accordance to the following:

(Left && !Center) || (Left ^ Right)

![image](https://user-images.githubusercontent.com/46231960/149710269-9f9146f8-9e48-400c-a574-82d11eb130cb.png)
