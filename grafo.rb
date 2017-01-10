require 'graphviz'

class Grafo
  def initialize
    @vertices = Hash.new
    @arestas = Hash.new
  end

  def adicionar_vertice(vertice)
    @vertices[vertice] = Hash.new 
  end

  def remover_vertice(vertice)
    @vertices[vertice].keys.each{|v| @vertices[v].delete vertice}
    @vertices.delete vertice

    @arestas.each {|aresta| @arestas.delete aresta.first if aresta.first.include? vertice}
  end

  def conectar(vertice1,vertice2, peso)
    @vertices[vertice1][vertice2] = peso
    @vertices[vertice2][vertice1] = peso
    @arestas[[vertice1,vertice2]] = peso
  end

  def arestas
    @arestas
  end

  def desconectar(vertice1, vertice2)
    @vertices[vertice1].delete vertice2
    @vertices[vertice2].delete vertice1 
  end

  def ordem
    @vertices.size
  end

  def vertices
    @vertices.keys
  end

  def lista_de_adjacencia
    @vertices.each {|vertice| puts "#{vertice.first} -> #{vertice[1].keys.sort}"}
  end

  def um_vertice
    @vertices.keys[rand(@vertices.size)]
  end

  def adjacentes(vertice)
    @vertices[vertice]
  end

  def grau(vertice)
    if @vertices[vertice][vertice]
      @vertices[vertice].size+1
    else
      @vertices[vertice]
    end
  end

  def desenhar_grafo
    digraph = GraphViz.new(:G, :type => :digraph)
    @arestas.keys.each do |aresta|
      u = aresta.first
      v = aresta.last
      instance_variable_set("@vertice_#{u}", digraph.add_nodes(u))
      instance_variable_set("@vertice_#{v}", digraph.add_nodes(v))
      digraph.add_edges(eval("@vertice_#{u}"), eval("@vertice_#{v}"), :label => (@arestas[aresta]))
    end
    digraph.output(:png => "grafo_original.png")
  end
end