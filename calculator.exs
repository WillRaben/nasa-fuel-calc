# Wilmer Raben application
# wilmer.raben@gmail.com
#
defmodule NasaFuelCalculator do
  defp calc_launch_fuel(weight, gravity) do
    Float.floor((weight * gravity * 0.042) - 33)
  end

  defp calc_land_fuel(weight, gravity) do
    Float.floor((weight * gravity * 0.033) - 42)
  end

  defp valid_route?(param) do
     Enum.all?(param, fn item -> ((elem(item, 0) == :launch) || (elem(item, 0) == :land)) and (elem(item, 1) > 0) end)
  end

  def fuel_for({_, weight , _}) when weight  < 0 do
    0
  end

  # mass * gravity * 0.042 - 33rounded down
  def fuel_for({:launch, weight, gravity})  do
    fuel = calc_launch_fuel(weight,gravity)
      if fuel > 0 do
        fuel + fuel_for({:launch,fuel,gravity})
      else
        0
      end
  end

  # mass * gravity * 0.033 - 42rounded down
  def fuel_for({:land, weight, gravity})  do
    fuel = calc_land_fuel(weight,gravity)
      if fuel > 0 do
        fuel + fuel_for({:land,fuel,gravity})
      else
        0
      end
  end

  def calc_mission_fuel(equipment_weight, route) when is_list(route) and equipment_weight > 0 and  length(route) >= 1 do
    valid_route = valid_route?(route)
    cond do
        valid_route == true ->
          reversed = Enum.reverse(route)
          Enum.reduce(reversed, {equipment_weight, 0}, fn route_stage, {equipment_weight, acc} ->
           {equipment_weight, round(acc + fuel_for({elem(route_stage,0), equipment_weight + acc, elem(route_stage, 1)}))}
          end)
        valid_route == false ->
          {:error , "Route is invalid"}
    end
  end

  def calc_mission_fuel(_equipment_weight, _route) do
    {:error , "Invalid paramaters, ensure positive equipment weight and non empty route list is given to the function"}
  end

end
  IO.puts("Input from the example:  28801, [{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 9.807}] ")
  {_ , result } = NasaFuelCalculator.calc_mission_fuel(28801, [{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 9.807}])
  IO.puts("The fuel needed for this missions is: #{result} units")

  IO.puts("Input from the example:  14606, [{:launch, 9.807},{:land, 3.711},{:launch, 3.711},{:land, 9.807}] ")
  {_ , result } = NasaFuelCalculator.calc_mission_fuel(14606, [{:launch, 9.807},{:land, 3.711},{:launch, 3.711},{:land, 9.807}])
  IO.puts("The fuel needed for this missions is: #{result} units")

  IO.puts("Input from the example:  75432, [{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 3.711},{:launch, 3.711},{:land, 9.807},] ")
  {_ , result } = NasaFuelCalculator.calc_mission_fuel(75432, [{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 3.711},{:launch, 3.711},{:land, 9.807},])
  IO.puts("The fuel needed for this missions is: #{result} units")
