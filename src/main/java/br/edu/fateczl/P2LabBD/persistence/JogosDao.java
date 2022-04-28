package br.edu.fateczl.P2LabBD.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.P2LabBD.model.Jogos;
import br.edu.fateczl.P2LabBD.model.Time;

@Component
public class JogosDao implements IJogosDao{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public List<Jogos> listaDatas() throws SQLException, ClassNotFoundException {
		
		Connection c = gDao.getConnection();
		List<Jogos> lista = new ArrayList<Jogos>();
		String sql = "SELECT CONVERT(VARCHAR, dia, 103) AS dia FROM datas_jogos";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogos j = new Jogos();
			j.setData(rs.getString("dia"));
			
			lista.add(j);
		}
		rs.close();
		ps.close();
		c.close();
		
		return lista;
	}

	@Override
	public List<Jogos> listaJogos(String data) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Jogos> lista = new ArrayList<Jogos>();
		String sql = "SELECT * FROM fn_jogos(?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogos j = new Jogos();
			j.setTimeA(rs.getString("timeA"));
			j.setTimeB(rs.getString("timeB"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(data);
			
			lista.add(j);
		}
		rs.close();
		ps.close();
		c.close();
		
		return lista;
	}

	@Override
	public List<Jogos> atualizaJogos(Jogos jogo) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	
}
