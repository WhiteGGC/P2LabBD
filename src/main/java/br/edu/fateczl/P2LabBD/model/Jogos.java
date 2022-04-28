package br.edu.fateczl.P2LabBD.model;

public class Jogos {

	 private int golsTimeA;
	 private int golsTimeB;
	 private String timeA;
	 private String timeB;
	 private String data;
	 
	public int getGolsTimeA() {
		return golsTimeA;
	}
	public void setGolsTimeA(int golsTimeA) {
		this.golsTimeA = golsTimeA;
	}
	public int getGolsTimeB() {
		return golsTimeB;
	}
	public void setGolsTimeB(int golsTimeB) {
		this.golsTimeB = golsTimeB;
	}
	public String getTimeA() {
		return timeA;
	}
	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}
	public String getTimeB() {
		return timeB;
	}
	public void setTimeB(String timeB) {
		this.timeB = timeB;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
	@Override
	public String toString() {
		return "Jogos [golsTimeA=" + golsTimeA + ", golsTimeB=" + golsTimeB + ", timeA=" + timeA + ", timeB=" + timeB
				+ ", data=" + data + "]";
	}
	  
}
