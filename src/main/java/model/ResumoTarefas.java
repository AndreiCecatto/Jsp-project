package model;

/*
 * Model simples para os cards do dashboard.
 * Cada campo vira um numero exibido na tela principal.
 */
public class ResumoTarefas {

    private int total;
    private int pendentes;
    private int concluidas;
    private int atrasadas;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getPendentes() {
        return pendentes;
    }

    public void setPendentes(int pendentes) {
        this.pendentes = pendentes;
    }

    public int getConcluidas() {
        return concluidas;
    }

    public void setConcluidas(int concluidas) {
        this.concluidas = concluidas;
    }

    public int getAtrasadas() {
        return atrasadas;
    }

    public void setAtrasadas(int atrasadas) {
        this.atrasadas = atrasadas;
    }
}
