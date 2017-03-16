# @file          min_vertex_cover.mod
# @author      Veronika Karpenko 20070875
# @brief        Implementation of the unweighted minimum vertex cover problem

param n, integer, >=3;                  # number of nodes

set V := 1..n;                          # set of nodes
set E, within V cross V;                # set of edges in graph

param c{(i,j) in E};                    # distance from node i to node j

var x{i in V}, binary;                  # 1=use node i, 0=otherwise

minimize indegree: sum {i in V} x[i];

s.t. idk{(i,j) in E}: x[i] + x[j] >=1; 

solve;

# graph-viz output 
printf 'graph {\n' > 'min_vertex_cover.gv';

# nodes
printf{i in V} "%g%s; ", i, 
    if x[i] then '[style="filled",color="red"]' else ''
    >> 'min_vertex_cover.gv';
printf "\n">> 'min_vertex_cover.gv';

# edges
printf{(i,j) in E:i<j} 
    ' %3d -- %3d ;\n', i, j  >> 'min_vertex_cover.gv';
printf '}\n' >> 'min_vertex_cover.gv';

# text output 
printf {i in V: x[i]} " Node = %g\n",  i;
printf "Minimum vertex cover size = %g\n",  indegree;

end;
