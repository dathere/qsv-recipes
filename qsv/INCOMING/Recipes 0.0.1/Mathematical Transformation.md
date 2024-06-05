## Mathematical Transformations with Embedded Scripts
To make it easier to run these transformations directly from the command line, here are the full commands again with the scripts embedded:

### Sine Function
```sh
qsv luau map Sine "local value = math.rad(tonumber(col['Angle'])); return math.sin(value)" angles.csv
```

### Cosine Function
```sh
qsv luau map Cosine "local value = math.rad(tonumber(col['Angle'])); return math.cos(value)" angles.csv
```
### Tangent Function
```sh
qsv luau map Tangent "local value = math.rad(tonumber(col['Angle'])); return math.tan(value)" angles.csv
```
### Exponential Function
```sh
qsv luau map Exponential "local value = tonumber(col['Value']); return math.exp(value)" values.csv
```
### Natural Log Transformation
```sh
qsv luau map Logarithm "local value = tonumber(col['Value']); return math.log(value)" values.csv
```
### Square Root 
```sh
qsv luau map SquareRoot "local value = tonumber(col['Value']); return math.sqrt(value)" values.csv
```
### Absolute Value Function
```sh
qsv luau map AbsoluteValue "local value = tonumber(col['Value']); return math.abs(value)" values.csv
```


