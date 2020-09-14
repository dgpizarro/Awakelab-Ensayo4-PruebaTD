package cl.awakelab.ensayo4.controller;

import java.util.List;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cl.awakelab.ensayo4.DAO.DoctoresDAO;
import cl.awakelab.ensayo4.DAO.EspecialidadesDAO;
import cl.awakelab.ensayo4.model.Doctores;
import cl.awakelab.ensayo4.model.Especialidades;

@RestController
@RequestMapping(path = "/api", headers = "Accept=application/json")
public class ApiController {

    @Autowired
    DoctoresDAO dd;

    @Autowired
    EspecialidadesDAO ed;

    static Logger log = Logger.getLogger(ApiController.class);

    @GetMapping(path = "/ldoctores/{idespecialidad}")
    public List<Doctores> getDoctores(@PathVariable int idespecialidad) {

        try {

            List<Doctores> ldocs = dd.listarDoctoresEspecialidad(idespecialidad);

            log.log(Level.INFO, "Búsqueda de doctores de especialidad ID: " + idespecialidad + " -> SQL");

            return ldocs;

        } catch (Exception e) {

            log.log(Level.ERROR, e);

            return null;

        }
    }

    @GetMapping(path = "/lesp")
    public List<Especialidades> getEspecialidades() {

        try {

            List<Especialidades> lesp = ed.listarEspecialidades();
            
            log.log(Level.INFO, "Búsqueda especiliades doctores  -> SQL");
            
            return lesp;

        } catch (Exception e) {

            log.log(Level.ERROR, e);

            return null;
        }

    }

}
