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

import br.edu.fateczl.P2LabBD.model.Time;
import br.edu.fateczl.P2LabBD.persistence.TimesDao;

@Controller
public class TabelaGeralController {

	@Autowired
	TimesDao tDao;
	
	@RequestMapping(name = "tabela_geral", value = "/tabela_geral", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Time> listaTimes = new ArrayList<Time>();
		String erro = "";
		
		try {
			listaTimes = tDao.listaTabelaGeral();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("listaTabelaGeral", listaTimes);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("tabela_geral");
	}
	
	/*
	@RequestMapping(name = "tabela_geral", value = "/tabela_geral", method = RequestMethod.POST)
	public ModelAndView op(@RequestParam Map<String, String> allRequestParam,
			ModelMap model) {
		List<Time> listaTimes = new ArrayList<Time>();
		String erro = "";
		
		try {
			listaTimes = tDao.listaTabelaGeral();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("listaTabelaGeral", listaTimes);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("tabela_geral");
		
	}
	*/
}
