package br.edu.fateczl.P2LabBD.model;

public class Time {

	private String nome;
	private int jogosDisputados;
	private int vitorias;
	private int empates;
	private int derrotas;
	private int golsMarcados;
	private int golsSofridos;
	private int saldoGols;
	private int pontos;
	private boolean rebaixamento;
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getJogosDisputados() {
		return jogosDisputados;
	}
	public void setJogosDisputados(int jogosDisputados) {
		this.jogosDisputados = jogosDisputados;
	}
	public int getVitorias() {
		return vitorias;
	}
	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}
	public int getEmpates() {
		return empates;
	}
	public void setEmpates(int empates) {
		this.empates = empates;
	}
	public int getDerrotas() {
		return derrotas;
	}
	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}
	public int getGolsMarcados() {
		return golsMarcados;
	}
	public void setGolsMarcados(int golsMarcados) {
		this.golsMarcados = golsMarcados;
	}
	public int getGolsSofridos() {
		return golsSofridos;
	}
	public void setGolsSofridos(int golsSofridos) {
		this.golsSofridos = golsSofridos;
	}
	public int getSaldoGols() {
		return saldoGols;
	}
	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}
	public int getPontos() {
		return pontos;
	}
	public void setPontos(int pontos) {
		this.pontos = pontos;
	}
	
	public boolean isRebaixamento() {
		return rebaixamento;
	}
	public void setRebaixamento(boolean rebaixamento) {
		this.rebaixamento = rebaixamento;
	}
	
	@Override
	public String toString() {
		return "Time [Nome=" + nome + ", jogosDisputados=" + jogosDisputados + ", vitorias=" + vitorias + ", empates="
				+ empates + ", derrotas=" + derrotas + ", golsMarcados=" + golsMarcados + ", golsSofridos="
				+ golsSofridos + ", saldoGols=" + saldoGols + ", pontos=" + pontos + "]";
	}
	
}
