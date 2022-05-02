package br.edu.fateczl.P2LabBD.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.P2LabBD.model.Jogos;
import br.edu.fateczl.P2LabBD.model.Time;
import br.edu.fateczl.P2LabBD.persistence.JogosDao;

@Controller
public class QuartasController {
	
	@Autowired
	JogosDao jDao;
	
	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Jogos> listaJogos = new ArrayList<Jogos>();
		String erro = "";

		try {
			listaJogos = jDao.listaQuartas();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("listaQuartas", listaJogos);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("quartas");
	}
}
