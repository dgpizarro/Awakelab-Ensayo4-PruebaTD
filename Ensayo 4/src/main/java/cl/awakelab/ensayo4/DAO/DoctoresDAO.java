package cl.awakelab.ensayo4.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import cl.awakelab.ensayo4.model.Doctores;

public class DoctoresDAO {

    JdbcTemplate template;

    public void setTemplate(JdbcTemplate template) {
        this.template = template;
    }

    static Logger log = Logger.getLogger(DoctoresDAO.class);

    public class DoctoresMapper implements RowMapper<Doctores> {
        public Doctores mapRow(ResultSet rs, int rowNum) throws SQLException {
            Doctores d = new Doctores();
            d.setIdDoctor(rs.getInt(1));
            d.setNombre(rs.getString(2));
            d.setApellido(rs.getString(3));
            return d;
        }
    }

    public List<Doctores> listarDoctoresEspecialidad(int idespecialidad) {
        
        String sql = "select iddoctor, nombre, apellido from doctores where idespecialidad = " + idespecialidad
                + " order by 2";

        return template.query(sql, new DoctoresMapper());
    }

}
