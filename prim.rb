require './grafo'

class Prim
  def initialize(grafo)
    @grafo = grafo
    @grafo_da_arvore = Grafo.new
  end

  def arvore_geradora_minima
    vertices_no_subgrafo = []
    arestas = @grafo.arestas.sort_by {|nome, custo| custo}.to_h.keys
    # arestas = @grafo.arestas.keys
    vertices_fora_subgrafo = @grafo.vertices
    arestas_possiveis = {}
    arestas_no_subgrafo = []

    vertice_escolhido = vertices_fora_subgrafo.shuffle!.pop
    vertices_no_subgrafo << vertice_escolhido
    
    while vertices_no_subgrafo.size < @grafo.vertices.size
      arestas.each do |aresta|
        arestas_possiveis[aresta] = @grafo.arestas[aresta] if (aresta.any? {|item| vertices_no_subgrafo.include?(item)}) and (vertices_no_subgrafo & aresta).sort != aresta.sort
      end
      arestas_no_subgrafo << arestas_possiveis.first
      arestas.delete arestas_possiveis.keys.first
      vertices_no_subgrafo = vertices_no_subgrafo | arestas_no_subgrafo.last.first
      arestas_possiveis = {}
    end
    arvore = arestas_no_subgrafo.to_h

    arvore.each do |aresta|
      u = aresta.first.first
      v = aresta.first.last
      peso = aresta.last
      @grafo_da_arvore.adicionar_vertice u
      @grafo_da_arvore.adicionar_vertice v
      @grafo_da_arvore.conectar(u, v, peso)
    end
    @grafo_da_arvore
    # p @grafo_da_arvore.arestas
  end

  def desenhar_grafo
    digraph = GraphViz.new(:G, :type => :digraph)
    @grafo_da_arvore.arestas.keys.each do |aresta|
      u = aresta.first
      v = aresta.last
      instance_variable_set("@vertice_#{u}", digraph.add_nodes(u))
      instance_variable_set("@vertice_#{v}", digraph.add_nodes(v))
      digraph.add_edges(eval("@vertice_#{u}"), eval("@vertice_#{v}"), :label => (@grafo_da_arvore.arestas[aresta]))
    end
    digraph.output(:png => "arvore_geradora_minima_prim.png")
  end
end