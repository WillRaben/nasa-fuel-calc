# nasa-fuel-calc
Exersice requested by software agency during recruitment process.

The objective was to create a function that would calculate the fuel requirements given two inputs: a positive number representing the equipment weight and a list of
tuples with the format  {:launch || :land, gravity}. Ex:  28801, [{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 9.807}]
Instructions:

functionality is available through: NasaFuelCalculator.calc_mission_fuel() 
with the correct aforementiones parameters to get a return of either an error string or a number representing the total fuel needed for the mission.

The problem seemed rather simple on first look, but it required both recursion and a reducer to solve somewhat idiomatically. 

running   elixir calculator.exs  will output 3 results matching both input and output from examples in the exercise sheet.
