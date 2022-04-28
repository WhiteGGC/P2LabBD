package br.edu.fateczl.P2LabBD.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.P2LabBD.model.Time;

public interface ITimesDao {

	public List<Time> listaTabelaGeral() throws SQLException, ClassNotFoundException;
	public List<Time> listaTabelaGrupos(String grupo) throws SQLException, ClassNotFoundException;
	
}
