
param MaxWeight;
set items;

param v{i in items};
param w{i in items};

var x{i in items}, binary;

maximize z: sum{i in items} v[i]*x[i];

s.t. weight: sum{i in items} w[i]*x[i] <= MaxWeight;

solve;

printf "\n=========================\n";
printf "max value found is %g \n",z;
printf {i in items: x[i]==1} "i = %s, v[%s]=%g, w[%s]=%g \n" ,i,  i, v[i], i, w[i];
printf "=========================\n";
printf "max z = %g, weight = %g\n", z, weight;
printf "=========================\n";

printf "\nThe knapsack contents: \n" ;
printf "%5s %7s %7s \n " , " Item " , " Weight " , " Value " ;
printf { i in 1..21 } "=" ; printf " \n " ;
printf { i in items : x[i] == 1} "%5s %7g %7g \n " , i , w[i] , v[i] ;
printf { i in 1..21 } "=" ; printf " \n " ;
printf "%5s %7g %7g \n \n" , " " , weight , z ;

end;