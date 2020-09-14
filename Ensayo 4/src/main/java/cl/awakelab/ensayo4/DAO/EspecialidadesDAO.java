package cl.awakelab.ensayo4.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


import cl.awakelab.ensayo4.model.Especialidades;

public class EspecialidadesDAO {

    JdbcTemplate template;

    public void setTemplate(JdbcTemplate template) {
        this.template = template;
    }

    static Logger log = Logger.getLogger(EspecialidadesDAO.class);

    public class EspecialidadesMapper implements RowMapper<Especialidades> {
        public Especialidades mapRow(ResultSet rs, int rowNum) throws SQLException {
            Especialidades e = new Especialidades();
            e.setIdEspecialidad(rs.getInt(1));
            e.setDescripcion(rs.getString(2));
            return e;
        }
    }
    
    public List<Especialidades> listarEspecialidades() {
        String sql = "select idespecialidad, descripcion from especialidades order by 2";

        return template.query(sql, new EspecialidadesMapper());
    }

}
