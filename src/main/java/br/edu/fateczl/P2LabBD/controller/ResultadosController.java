package br.edu.fateczl.P2LabBD.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.P2LabBD.model.Jogos;
import br.edu.fateczl.P2LabBD.persistence.JogosDao;

@Controller
public class ResultadosController {
	
	@Autowired
	JogosDao jDao;
	
	@RequestMapping(name = "resultados", value = "/resultados", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Jogos> listaDatas = new ArrayList<Jogos>();
		String erro = "";
		
		try {
			listaDatas = jDao.listaDatas();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("listaDatas", listaDatas);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("resultados");
	}
	
	@RequestMapping(name = "resultados", value = "/resultados", method = RequestMethod.POST)
	public ModelAndView op(@RequestParam Map<String, String> allRequestParam,
			ModelMap model) {
		List<Jogos> listaJogos = new ArrayList<Jogos>();
		String erro = "";
		String data = "";
		for (String key : allRequestParam.keySet()) {
			if (key.equals("buttonData")) {
				data = allRequestParam.get(key);
			}
		}
		try {
			listaJogos = jDao.listaJogos(data);
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			init(model);
			model.addAttribute("listaJogos", listaJogos);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("resultados");
		
	}
}
