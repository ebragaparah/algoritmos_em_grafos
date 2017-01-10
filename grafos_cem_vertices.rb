require './grafo'
require './prim'
require './kruskal'

grafo_denso = Grafo.new
(1..100).each {|vertice| grafo_denso.adicionar_vertice(vertice.to_s) }
(1..100).to_a.combination(2).to_a.each {|u, v| grafo_denso.conectar(u.to_s, v.to_s, Random.rand(20))}

prim = Prim.new grafo_denso
inicio = Time.now
prim.arvore_geradora_minima
fim = Time.now
p "Tempo gasto para executar o algoritmo de Prim num grafo denso de cem vertices: #{fim - inicio} segundos"

kruskal = Kruskal.new grafo_denso
inicio = Time.now
kruskal.arvore_geradora_minima
fim = Time.now
p "Tempo gasto para executar o algoritmo de Kruskal num grafo denso de cem vertices: #{fim - inicio} segundos"

puts "\n\n\n"

grafo_esparso = Grafo.new
(1..100).each {|vertice| grafo_esparso.adicionar_vertice(vertice.to_s) }
(1..100).to_a.combination(2).to_a.each do |u, v|
  if grafo_esparso.arestas.size < ((grafo_esparso.vertices.size - 1) * 4)
    grafo_esparso.conectar(u.to_s, v.to_s, Random.rand(20))
  else
    break
  end
end

prim = Prim.new grafo_esparso
inicio = Time.now
prim.arvore_geradora_minima
fim = Time.now
p "Tempo gasto para executar o algoritmo de Prim num grafo esparso de cem vertices: #{fim - inicio} segundos"


kruskal = Kruskal.new grafo_esparso
inicio = Time.now
kruskal.arvore_geradora_minima
fim = Time.now
p "Tempo gasto para executar o algoritmo de Kruskal num grafo esparso de cem vertices: #{fim - inicio} segundos"