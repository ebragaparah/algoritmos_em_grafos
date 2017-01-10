require './kruskal'
require './prim'

g = Grafo.new
g.adicionar_vertice 'a'
g.adicionar_vertice 'b'
g.adicionar_vertice 'c'
g.adicionar_vertice 'd'
g.adicionar_vertice 'e'
g.adicionar_vertice 'f'

g.adicionar_vertice 'g'
# g.adicionar_vertice 'h'
# g.adicionar_vertice 'i'

g.conectar 'a', 'b', 7
g.conectar 'a', 'd', 5
g.conectar 'b', 'd', 9
g.conectar 'b', 'c', 8
g.conectar 'b', 'e', 7
g.conectar 'c', 'e', 5
g.conectar 'd', 'f', 6
g.conectar 'd', 'e', 15
g.conectar 'f', 'e', 8
g.conectar 'g', 'e', 9
g.conectar 'g', 'f', 11

g.desenhar_grafo

# g.conectar 'a', 'b', 4
# g.conectar 'a', 'h', 8
# g.conectar 'b', 'c', 8
# g.conectar 'b', 'h', 11
# g.conectar 'c', 'd', 7
# g.conectar 'c', 'f', 4
# g.conectar 'c', 'i', 2
# g.conectar 'd', 'e', 9
# g.conectar 'd', 'f', 14
# g.conectar 'e', 'f', 10
# g.conectar 'f', 'g', 2
# g.conectar 'g', 'h', 1
# g.conectar 'g', 'i', 6
# g.conectar 'h', 'i', 7

# g.desenhar_grafo

k = Kruskal.new g
k.arvore_geradora_minima
k.desenhar_grafo

p = Prim.new g
p.arvore_geradora_minima
p.desenhar_grafo