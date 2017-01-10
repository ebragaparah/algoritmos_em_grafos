require './grafo'

class Kruskal
  def initialize(grafo)
    require 'set'

    @grafo = grafo
    @arestas_ordenadas = grafo.arestas.sort_by{|aresta,custo| custo}
    @arvore = Grafo.new
    @vertices = []
  end

  def arvore_geradora_minima
    @grafo.vertices.each{ |v| @vertices.push(Set.new [v])}
    while @vertices.size > 1 do
      aresta = @arestas_ordenadas.shift
      v = aresta[0][0]
      w = aresta[0][1]
      peso = aresta[1]
      conjunto_v = Set.new
      conjunto_w = Set.new
      @vertices.each{ |conjunto| 
        if conjunto.include?(v)
          conjunto_v = conjunto
        end
        if conjunto.include?(w)
          conjunto_w = conjunto
        end
      }

      if conjunto_v != conjunto_w
        conjunto_novo =  conjunto_v + conjunto_w
        @vertices.push conjunto_novo
        @vertices.delete conjunto_v
        @vertices.delete conjunto_w
        @arvore.adicionar_vertice v
        @arvore.adicionar_vertice w
        @arvore.conectar(v,w,peso)
      end
    end

    @arvore
    # p @arvore.arestas
  end

  def desenhar_grafo
    digraph = GraphViz.new(:G, :type => :digraph)
    @arvore.arestas.keys.each do |aresta|
      u = aresta.first
      v = aresta.last
      instance_variable_set("@vertice_#{u}", digraph.add_nodes(u))
      instance_variable_set("@vertice_#{v}", digraph.add_nodes(v))
      digraph.add_edges(eval("@vertice_#{u}"), eval("@vertice_#{v}"), :label => (@arvore.arestas[aresta]))
    end
    digraph.output(:png => "arvore_geradora_minima_kruskal.png")
  end
end