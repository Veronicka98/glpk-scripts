# @file         max_degree.mod
# @author       kmurphy
# @brief        Implementation of the graph maximum degree problem

param n, integer, >=3;                  # number of nodes

set V := 1..n;                          # set of nodes
set E, within V cross V;                # set of edges in graph

param c{(i,j) in E};                    # distance from node i to node j

var x{i in V}, binary;                  # 1=use node i, 0=otherwise

minimize indegree: sum {(i,j) in E} x[i];

s.t. nodes : sum{i in V} x[i] >= 1;
s.t. idk{(i,j) in E}: x[i] + x[j] >=1; 

solve;

# graph-viz output 
printf 'graph {\n' > 'graph.gv';

# nodes
printf{i in V} "%g%s; ", i, 
    if x[i]=0 then '[style="filled",color="red"]' else ''
    >> 'graph.gv';
printf "\n">> 'graph.gv';

# edges
printf{(i,j) in E:i<j} 
    ' %3d -- %3d ;\n', i, j  >> 'graph.gv';
printf '}\n' >> 'graph.gv';

# text output 
printf {i in V: x[i]=0} " Vertex with maximum degree = %g\n",  i;
printf "Minimum vertex cover size = %g\n",  (sum{(i,j)in E} 1)-indegree;
