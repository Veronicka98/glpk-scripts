# @file          min_edge_dominating_set.mod
# @author      Veronika Karpenko 20070875
# @brief        Implementation of the minimum edge dominating set problem

param n, integer, >=3;                  # number of nodes

set V := 1..n;                          # set of nodes
set E, within V cross V;                # set of edges in graph

param c{(i,j) in E};                    # distance from node i to node j

var x{(i,j) in E}, binary;                  # 1=use node i, 0=otherwise

minimize indegree: sum{(i,j) in E} x[i,j];

s.t. idk {(h,i) in E, (i,j) in E, (j,k) in E} : (x[h,i] + x[i,j] + x[j,k]) >= 1;
solve;

# graph-viz output 
printf 'graph {\n' > 'min_edge_dominating_set.gv';

# edges
printf{(i,j) in E:i<j} 
    ' %3d -- %3d %s;\n', i, j , if x[i,j] then '[style="bold",color="red"]' else '' 
	>> 'min_edge_dominating_set.gv';
printf '}\n' >> 'min_edge_dominating_set.gv';


printf("\nFrom node   To node    x[i,j]\n");
printf{(i,j) in E: x[i,j]&&i<j} "      %3d      %3d   %8g\n", i, j, x[i,j];

# text output 
printf "idk = %g\n", indegree;

end;
