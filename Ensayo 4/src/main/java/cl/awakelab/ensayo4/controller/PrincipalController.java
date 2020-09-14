package cl.awakelab.ensayo4.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import cl.awakelab.ensayo4.DAO.AgendasDAO;
import cl.awakelab.ensayo4.DAO.DoctoresDAO;
import cl.awakelab.ensayo4.DAO.EspecialidadesDAO;
import cl.awakelab.ensayo4.controller.PrincipalController;
import cl.awakelab.ensayo4.model.Agendas;
import cl.awakelab.ensayo4.model.Doctores;
import cl.awakelab.ensayo4.model.Especialidades;


@Controller
public class PrincipalController {

    static Logger log = Logger.getLogger(PrincipalController.class);

    @Autowired
    AgendasDAO ad;

    @Autowired
    DoctoresDAO dd;

    @Autowired
    EspecialidadesDAO ed;
    
    public List<Especialidades> getEspecialidades (int port){
        //String uri = "http://localhost:"+port+"/ensayo4/api/lesp";
        String uri = "http://localhost:8085/ensayo4/api/lesp";
        
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<Especialidades[]> respuesta = restTemplate.getForEntity(uri, Especialidades[].class);
                    
        return Arrays.asList(respuesta.getBody());
    }
    
    public List<Doctores> getDoctores (int port, int idEspecialidad){
        //String uri = "http://localhost:"+ port +"/ensayo4/api/ldoctores/" + idEspecialidad;
        String uri = "http://localhost:8085/ensayo4/api/ldoctores/" + idEspecialidad;
        
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<Doctores[]> respuesta = restTemplate.getForEntity(uri, Doctores[].class);
                    
        return Arrays.asList(respuesta.getBody());
    }

    @RequestMapping({ "/index", "/" })
    public String irListadoReservas(Model m) {
        
        try {
            
            List<Agendas> lagendas = ad.listarReservas();
            m.addAttribute("reservas", lagendas);
            
            log.log(Level.INFO, "Búsqueda reservas agendadas  -> SQL AgendasDAO");
            log.log(Level.INFO, "Ingreso a index");
            
        } catch (Exception e) {
            log.log(Level.ERROR, e);
        }
        
        return "ListaReservas";
    }

    @RequestMapping("/ingresarReserva")
    public String irIngresoReserva(Model m, HttpServletRequest r) {
        
        int port = r.getServerPort();
        
        m.addAttribute("command", new Agendas());
        
        try {
            
            m.addAttribute("especialiades", getEspecialidades(port));
            
            log.log(Level.INFO, "Ingreso a formulario nueva reserva.");
            
        } catch (Exception e) {
            log.log(Level.ERROR, e);
        }
        
        return "FormIngresoReserva2";
    }

    @RequestMapping(value = "/reservarHora", method = RequestMethod.POST)
    public String agendarReserva(Agendas a) {
        
        try {
            
            ad.crearReserva(a);
            
            log.log(Level.INFO, "Nueva reserva creada exitosamente.");
            
            return "redirect:/index?alert=true";
            
        } catch (Exception e) {
            
            log.log(Level.ERROR, e);
            
            return "redirect:/ingresarReserva?alert=true";
        }
        
    }

    @RequestMapping("/editarReserva/{idAgenda}")
    public String irEditarReserva(@PathVariable int idAgenda, Model m, HttpServletRequest r) {
        
        int port = r.getServerPort();
        
        try {
            
            Agendas a_edit = ad.buscarReservaByID(idAgenda);
            
            log.log(Level.INFO, "Búsqueda detalle reserva ID: " + idAgenda + " -> SQL");
            
            int idEspecialidad = a_edit.getDoctor().getEspecialidad().getIdEspecialidad();
            
            m.addAttribute("especialiades", getEspecialidades(port));
            
            m.addAttribute("doctores", getDoctores(port, idEspecialidad ));
            
            m.addAttribute("command", a_edit);
            
            log.log(Level.INFO, "Ingreso a modal formulario editar reserva ID: " + idAgenda);
            
            return "FormEditReserva";
            
        } catch (Exception e) {
            
            log.log(Level.ERROR, e);
            
            return "redirect:/index";
        }
      
    }
    
    @RequestMapping(value = "/editarHora", method = RequestMethod.POST)
    public String modificarReserva(Agendas a) {
        
        try {
            
            ad.actualizarReserva(a);
            
            log.log(Level.INFO, "Edición correcta de reserva ID: " + a.getIdAgenda());
            
            return "redirect:/index?alert2=true";
            
        } catch (Exception e) {
            
            log.log(Level.ERROR, e);
            
            return "redirect:/editarReserva/" + a.getIdAgenda();
        }
        
    }
    
    @RequestMapping("/eliminarReserva/{idAgenda}/{idPaciente}")
    public String quitarReserva(@PathVariable int idAgenda, @PathVariable int idPaciente) {
        
        try {
            
            ad.eliminarReserva(idAgenda, idPaciente);
            
            log.log(Level.INFO, "Eliminación correcta de reserva ID: " + idAgenda);
            
            return "redirect:/index?alert3=true";
            
        } catch (Exception e) {
            
            log.log(Level.ERROR, e);
            
            return "redirect:/index?alert4=true";
            
        }
        
    }

}
