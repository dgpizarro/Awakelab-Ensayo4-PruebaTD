package cl.awakelab.ensayo4.DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.jdbc.core.RowMapper;

import cl.awakelab.ensayo4.model.Agendas;
import cl.awakelab.ensayo4.model.Doctores;
import cl.awakelab.ensayo4.model.Especialidades;
import cl.awakelab.ensayo4.model.Pacientes;

public class AgendasDAO {

    JdbcTemplate template;

    public void setTemplate(JdbcTemplate template) {
        this.template = template;
    }

    static Logger log = Logger.getLogger(AgendasDAO.class);

    public class AgendasMapper implements RowMapper<Agendas> {
        public Agendas mapRow(ResultSet rs, int rowNum) throws SQLException {
            Agendas a = new Agendas();
            Doctores d = new Doctores();
            Especialidades e = new Especialidades();
            Pacientes p = new Pacientes();
            p.setNombre(rs.getString(1));
            p.setApellido(rs.getString(2));
            p.setRutPaciente(rs.getString(3));
            e.setDescripcion(rs.getString(4));
            d.setNombre(rs.getString(5));
            d.setApellido(rs.getString(6));
            a.setFecha(rs.getDate(7));
            a.setHoraDesde(rs.getString(8));
            a.setIdAgenda(rs.getInt(9));
            p.setIdPaciente(rs.getInt(10));
            e.setIdEspecialidad(rs.getInt(11));
            d.setIdDoctor(rs.getInt(12));
            d.setEspecialidad(e);
            a.setDoctor(d);
            a.setPaciente(p);
            return a;
        }
    }

    public List<Agendas> listarReservas() {

        String sql = "select p.nombre, p.apellido, rutpaciente, descripcion, d.nombre, d.apellido, "
                + "fecha, TO_CHAR(horadesde, 'HH24:MI'), idagenda, p.idpaciente, e.idespecialidad, d.iddoctor "
                + " from pacientes p inner join agendas a on (p.idpaciente = a.idpaciente) "
                + "inner join doctores d on (a.iddoctor = d.iddoctor) inner join especialidades e on "
                + "(d.idespecialidad = e.idespecialidad) order by 7 desc";

        return template.query(sql, new AgendasMapper());
    }
    
    public Agendas buscarReservaByID (int idAgenda) {
        
        String sql = "select p.nombre, p.apellido, rutpaciente, descripcion, d.nombre, d.apellido, "
                + "fecha, TO_CHAR(horadesde, 'HH24:MI'), idagenda, p.idpaciente, e.idespecialidad, d.iddoctor "
                + " from pacientes p inner join agendas a on (p.idpaciente = a.idpaciente) "
                + "inner join doctores d on (a.iddoctor = d.iddoctor) inner join especialidades e on "
                + "(d.idespecialidad = e.idespecialidad) where idagenda = ? order by 7 desc";
        
        try {
            return template.queryForObject(sql, new Object[] { idAgenda }, new AgendasMapper());
        } catch (Exception e) {
            return null;        
        }
    }

    public Boolean crearReserva(final Agendas a) {
                
        String sql = "INSERT ALL";
        sql += " INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (?, ?, ?, ?) ";
        sql += " INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (?, ?, ?, ?, TO_DATE(?, 'HH24:MI'), 15) ";
        sql += "SELECT * FROM dual";

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String fechaComoCadena = sdf.format(a.getFecha());

        return template.execute(sql, new PreparedStatementCallback<Boolean>() {
            @Override
            public Boolean doInPreparedStatement(PreparedStatement ps) throws SQLException, DataAccessException {
                
                int idPaciente;
                try {
                    String sql2 = "select max(idpaciente) from pacientes";
                    idPaciente = template.queryForObject(sql2, Integer.class);
                    idPaciente += 10;
                } catch (Exception e) {
                    idPaciente = 1;
                }

                int idAgenda;
                try {
                    String sql3 = "select max(idagenda) from agendas";
                    idAgenda = template.queryForObject(sql3, Integer.class);
                    idAgenda += 1;
                } catch (Exception e) {
                    idAgenda = 1;
                }
                
                ps.setInt(1, idPaciente);
                ps.setString(2, a.getPaciente().getRutPaciente());
                ps.setString(3, a.getPaciente().getNombre());
                ps.setString(4, a.getPaciente().getApellido());
                
                ps.setInt(5, idPaciente);
                ps.setInt(6, a.getDoctor().getIdDoctor());
                ps.setInt(7, idAgenda);
                ps.setString(8, fechaComoCadena);
                ps.setString(9, a.getHoraDesde());
                
                return ps.execute();
            }
        });

    }
    
    public Boolean actualizarReserva (final Agendas a) {
        
        String sql = "UPDATE agendas set idDoctor = ?, fecha = ?, horaDesde = TO_DATE(?, 'HH24:MI') where idAgenda = ?";
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String fechaComoCadena = sdf.format(a.getFecha());
        
        return template.execute(sql, new PreparedStatementCallback<Boolean>() {
            @Override
            public Boolean doInPreparedStatement(PreparedStatement ps) throws SQLException, DataAccessException {
                                
                ps.setInt(1, a.getDoctor().getIdDoctor());
                ps.setString(2, fechaComoCadena);
                ps.setString(3, a.getHoraDesde());
                ps.setInt(4, a.getIdAgenda());
                
                return ps.execute();
            }
        });
        
    }
    
    public void eliminarReserva (int idAgenda, int idPaciente) {
        
        String sql1="DELETE from agendas where idAgenda = " + idAgenda;
        template.update(sql1);
        
        String sql2="DELETE from pacientes where idPaciente = " + idPaciente;
        template.update(sql2);
        
    }

}
