package cl.awakelab.ensayo4.model;

public class Doctores {

    private int idDoctor;
    private String rutDoctor;
    private String nombre;
    private String apellido;
    private Especialidades especialidad;

    public Doctores() {

    }

    public int getIdDoctor() {
        return idDoctor;
    }

    public void setIdDoctor(int idDoctor) {
        this.idDoctor = idDoctor;
    }

    public String getRutDoctor() {
        return rutDoctor;
    }

    public void setRutDoctor(String rutDoctor) {
        this.rutDoctor = rutDoctor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public Especialidades getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(Especialidades especialidad) {
        this.especialidad = especialidad;
    }

}
