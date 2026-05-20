package model;

import java.math.BigDecimal;

// Model usado pelo dashboard para exibir indicadores calculados no banco.
public class ResumoEstoque {

    private int totalProdutos;
    private int totalCategorias;
    private int produtosEstoqueBaixo;
    private int quantidadeTotalItens;
    private BigDecimal valorTotalEstoque = BigDecimal.ZERO;

    public int getTotalProdutos() {
        return totalProdutos;
    }

    public void setTotalProdutos(int totalProdutos) {
        this.totalProdutos = totalProdutos;
    }

    public int getTotalCategorias() {
        return totalCategorias;
    }

    public void setTotalCategorias(int totalCategorias) {
        this.totalCategorias = totalCategorias;
    }

    public int getProdutosEstoqueBaixo() {
        return produtosEstoqueBaixo;
    }

    public void setProdutosEstoqueBaixo(int produtosEstoqueBaixo) {
        this.produtosEstoqueBaixo = produtosEstoqueBaixo;
    }

    public int getQuantidadeTotalItens() {
        return quantidadeTotalItens;
    }

    public void setQuantidadeTotalItens(int quantidadeTotalItens) {
        this.quantidadeTotalItens = quantidadeTotalItens;
    }

    public BigDecimal getValorTotalEstoque() {
        return valorTotalEstoque;
    }

    public void setValorTotalEstoque(BigDecimal valorTotalEstoque) {
        this.valorTotalEstoque = valorTotalEstoque;
    }
}
