package br.edu.fateczl.P2LabBD.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.P2LabBD.model.Jogos;

public interface IJogosDao {

	public List<Jogos> listaDatas() throws SQLException, ClassNotFoundException;
	public List<Jogos> listaJogos(String data) throws SQLException, ClassNotFoundException;
	public List<Jogos> atualizaJogos(Jogos jogo) throws SQLException, ClassNotFoundException;
	
}
