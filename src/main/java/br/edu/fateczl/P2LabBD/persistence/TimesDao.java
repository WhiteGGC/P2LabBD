package br.edu.fateczl.P2LabBD.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.P2LabBD.model.Time;

@Component
public class TimesDao implements ITimesDao{
	
	@Autowired
	GenericDao gDao;
	
	@Override
	public List<Time> listaTabelaGeral() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Time> lista = new ArrayList<Time>();
		String sql = "SELECT * FROM fn_tabela_geral() ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setNome(rs.getString("nomeTime"));
			t.setJogosDisputados(rs.getInt("jogosDisputados"));
			t.setVitorias(rs.getInt("vitorias"));
			t.setEmpates(rs.getInt("empates"));
			t.setDerrotas(rs.getInt("derrotas"));
			t.setGolsMarcados(rs.getInt("golsMarcados"));
			t.setGolsSofridos(rs.getInt("golsSofridos"));
			t.setPontos(rs.getInt("pontos"));
			t.setSaldoGols(rs.getInt("saldoGols"));
			t.setRebaixamento(rs.getBoolean("fg_rebaixamento"));
			
			lista.add(t);
		}
		rs.close();
		ps.close();
		c.close();
		
		return lista;
	}

	@Override
	public List<Time> listaTabelaGrupos(String grupo) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Time> lista = new ArrayList<Time>();
		String sql = "SELECT * FROM fn_tabela_grupos(?) ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setNome(rs.getString("nomeTime"));
			t.setJogosDisputados(rs.getInt("jogosDisputados"));
			t.setVitorias(rs.getInt("vitorias"));
			t.setEmpates(rs.getInt("empates"));
			t.setDerrotas(rs.getInt("derrotas"));
			t.setGolsMarcados(rs.getInt("golsMarcados"));
			t.setGolsSofridos(rs.getInt("golsSofridos"));
			t.setPontos(rs.getInt("pontos"));
			t.setSaldoGols(rs.getInt("saldoGols"));
			t.setRebaixamento(rs.getBoolean("fg_rebaixamento"));
			
			lista.add(t);
		}
		rs.close();
		ps.close();
		c.close();
		
		return lista;
	}
	
	
}
