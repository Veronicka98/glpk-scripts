# @file         max_matching.mod
# @author       kmurphy
# @brief        Implementation of the graph maximum matching problem

param n, integer, >=3;                  # number of nodes

set V := 1..n;                          # set of nodes
set E, within V cross V;                # set of edges in graph

param c{(i,j) in E};                    # distance from node i to node j

var x{(i,j) in E}, binary;              # 1=use arc (i,j), 0=otherwise

maximize matching: sum {(i,j) in E} c[i,j]*x[i,j];

s.t. leave{i in V}: sum{(i,j) in E} x[i,j] <= 1;
s.t. enter{i in V}: sum{(i,j) in E} x[j,i] <= 1;

solve;

printf 'graph {\n' > 'graph.gv';
printf{(i,j) in E:i<j} 
    ' %3d -- %3d [len="%g",label="%g"%s];\n', i, j , c[i,j], c[i,j], 
    if x[i,j] then ', style="bold", color="red"' else '' >> 'graph.gv';
printf '}\n' >> 'graph.gv';

end;