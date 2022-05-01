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
		int golsTimeA = -1;
		int golsTimeB = -1;
		String timeA = "";
		String timeB = "";
		boolean inserir = false;
		
		System.out.println(allRequestParam);
		for (String key : allRequestParam.keySet()) {
			if (key.equals("buttonData")) {
				data = allRequestParam.get(key);
			}
			if(key.equals("buttonMarcar")) {
				 inserir = true;
			}
		}
		if(allRequestParam.containsKey("buttonMarcar")) {
//			for (String key : allRequestParam.keySet()) {
//				if (key.equals("timeA")) {
//					timeA = allRequestParam.get(key);
//				}
//				if (key.equals("timeB")) {
//					timeB = allRequestParam.get(key);
//				}
//				if (key.equals("golsTimeA")) {
//					golsTimeA = Integer.parseInt(allRequestParam.get(key));
//				}
//				if (key.equals("golsTimeB")) {
//					golsTimeB = Integer.parseInt(allRequestParam.get(key));
//				}
//
//				if(timeA != "" && timeB != "" && golsTimeA != -1 && golsTimeB != -1) {
//					Jogos jogo = new Jogos();
//					jogo.setGolsTimeA(golsTimeA);
//					jogo.setGolsTimeB(golsTimeB);
//					jogo.setTimeA(timeA);
//					jogo.setTimeB(timeB);
//					System.out.println(jogo);
//					listaJogos.add(jogo);
//					golsTimeA = -1;
//					golsTimeB = -1;
//					timeA = "";
//					timeB = "";
//				}
//			}
		}
		try {
//			for (Jogos jogo : listaJogos) {
//				jDao.atualizaJogos(jogo);
//			}
			if(inserir == true) {
				System.out.println("chegou aqui");
				jDao.atualizaJogosAleatorio();
				model.addAttribute("mensagem", "Times aleatórios inseridos com sucesso");
			}
		
			listaJogos = jDao.listaJogos(data);
			System.out.println(listaJogos);
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
