package cl.awakelab.ensayo4.test;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.isA;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.*;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.junit.runners.MethodSorters;

import cl.awakelab.ensayo4.DAO.AgendasDAO;
import cl.awakelab.ensayo4.model.Agendas;

@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class PrincipalControllerTest {
    
    @Autowired
    private WebApplicationContext wac;
    
    @Autowired
    private JdbcTemplate template;
    
    @Autowired
    AgendasDAO ad;

    private MockMvc mock;
    
    @Before
    public void setUp() throws Exception {
        this.mock = MockMvcBuilders.webAppContextSetup(wac).build();        
    }

    @Test
    public void t1_testIrListadoReservas() throws Exception {
        this.mock
        .perform(get("/index"))
        .andExpect(status().isOk())
        .andExpect(view().name("ListaReservas"))
        .andExpect(model().attributeExists("reservas"))
        .andExpect(model().attribute("reservas", isA(Iterable.class)))
        .andExpect(model().attribute("reservas",
                        hasItem(allOf(
                            hasProperty("paciente", hasProperty("nombre",is("Quinn"))),
                            hasProperty("paciente", hasProperty("apellido",is("Shelton"))),
                            hasProperty("paciente", hasProperty("rutPaciente",is("10748295-7"))),
                            hasProperty("doctor", hasProperty("idDoctor",is(11))),
                            hasProperty("idAgenda", is(4))))))
        .andDo(print());
    }
    
    @Test
    public void t2_testIrIngresoReservas() throws Exception {        
        this.mock
        .perform(get("/ingresarReserva"))
        .andExpect(status().isOk())
        .andExpect(view().name("FormIngresoReserva2"))
        .andExpect(model().attributeExists("command"))
        .andExpect(model().attribute("command", isA(Agendas.class)))
        .andExpect(model().attributeExists("especialiades"))
        .andExpect(model().attribute("especialiades", isA(Iterable.class)))
        .andExpect(model().attribute("especialiades",
                        hasItem(allOf(
                            hasProperty("idEspecialidad",is(1)),
                            hasProperty("descripcion", is("Proctología"))))))
        .andDo(print());
    }
    
    @Test
    public void t3_testAgendarReservas() throws Exception {
        this.mock
        .perform(post("/reservarHora")
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        .param("paciente.nombre", "Sujeto")
        .param("paciente.apellido", "De Prueba")
        .param("paciente.rutPaciente", "1111-k")
        .param("doctor.idDoctor", "1")
        .param("fecha", "2020-12-12")
        .param("horaDesde", "12:30"))        
        .andExpect(status().isFound())
        .andExpect(view().name("redirect:/index?alert=true"))
        .andDo(print());
    }
    
    @Test
    public void t4_testIrEditarReserva() throws Exception {
        this.mock
        .perform(get("/editarReserva/1"))
        .andExpect(status().isOk())
        .andExpect(view().name("FormEditReserva"))
        .andExpect(model().attributeExists("command"))
        .andExpect(model().attribute("command", isA(Agendas.class)))
        .andExpect(model().attribute("command", hasProperty("idAgenda", is(1))))
        .andExpect(model().attributeExists("especialiades"))
        .andExpect(model().attribute("especialiades", isA(Iterable.class)))
        .andExpect(model().attribute("especialiades",
                        hasItem(allOf(
                            hasProperty("idEspecialidad",is(1)),
                            hasProperty("descripcion", is("Proctología"))))))
        .andExpect(model().attributeExists("doctores"))
        .andExpect(model().attribute("doctores", isA(Iterable.class)))
        .andExpect(model().attribute("doctores",
                        hasItem(allOf(
                            hasProperty("idDoctor",is(41)),
                            hasProperty("nombre",is("Juan")),
                            hasProperty("apellido", is("Manogrande"))))))
        .andDo(print());
    }
    
    @Test
    public void t5_testEdiatrReserva() throws Exception {
        this.mock
        .perform(post("/editarHora")
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        .param("paciente.idPaciente", "1")
        .param("idAgenda", "1")
        .param("paciente.nombre", "Rodolfo")
        .param("paciente.apellido", "Nalgonius")
        .param("paciente.rutPaciente", "15940287-3")
        .param("doctor.idDoctor", "41")
        .param("fecha", "2020-12-12")
        .param("horaDesde", "12:30"))        
        .andExpect(status().isFound())
        .andExpect(view().name("redirect:/index?alert2=true"))
        .andDo(print());
    }
    
    @Test
    public void t6_testEliminarReserva() throws Exception {
        
        String sql2 = "select max(idpaciente) from pacientes";
        int idPaciente = template.queryForObject(sql2, Integer.class);
        
        String sql3 = "select max(idagenda) from agendas";
        int idAgenda = template.queryForObject(sql3, Integer.class);
                
        this.mock 
            .perform(get("/eliminarReserva/"+idAgenda+"/"+idPaciente))
            .andExpect(status().isFound())
            .andExpect(view().name("redirect:/index?alert3=true")) 
            .andDo(print());
        
        assertNull(ad.buscarReservaByID(idAgenda));
         
    }

}
