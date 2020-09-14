<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Lista Reservas</title>
<!-- DataTable -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src=" https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.5/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.5/js/responsive.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.10.21/dataRender/datetime.js"></script> 
    <script src="https://momentjs.com/downloads/moment-with-locales.min.js"></script> 
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.5/css/responsive.bootstrap4.min.css">
 <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
</head>
<body class="bg-light">
    
     <nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-top">
        <span class="navbar-brand" >Clínica El Vacunazo</span>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
            aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index">Listado </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/ingresarReserva">Reservas</a>
                </li>
            </ul>
        </div>
    </nav>


    <main role="main" class="container py-5">
    
        <div class="pt-5">
            <h3>Listado de Reservas</h3>
        </div>
        
         <c:if test="${param.alert == true}">
            <div class="alert alert-success alert-dismissible fade show my-4" role="alert">
				   Reserva agendada correctamente.
				  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
			</div>
        </c:if>
        
        <c:if test="${param.alert2 == true}">
            <div class="alert alert-success alert-dismissible fade show my-4" role="alert">
                   Reserva actualizada correctamente.
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
            </div>
        </c:if>
        
        <c:if test="${param.alert3 == true}">
            <div class="alert alert-success alert-dismissible fade show my-4" role="alert">
                   Reserva eliminada correctamente.
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
            </div>
        </c:if>
        
        <c:if test="${param.alert4 == true}">
            <div class="alert alert-danger alert-dismissible fade show my-4" role="alert">
                   Ocurrió un error al eliminar la reserva.
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
            </div>
        </c:if>
        
         <div class="row pt-4">
            <div class="col-12 bg-light">
                <div id="contenedor1">
                    <table id="tabla1" class="table table-striped table-sm display responsive" style="width:100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>Paciente</th>
                                <th>Doctor(a) </th>
                                <th>Especialidad</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${reservas}">
                                <tr>
                                    <td > <span class="font-weight-bold"> <c:out value="${r.getPaciente().getNombre()}" />&nbsp;<c:out value="${r.getPaciente().getApellido()}" /> </span> <br> <c:out value="${r.getPaciente().getRutPaciente()}" /> </td>
                                    <td ><c:out value="${r.getDoctor().getNombre()}" />&nbsp;<c:out value="${r.getDoctor().getApellido()}" /> </td>    
                                    <td ><c:out value="${r.getDoctor().getEspecialidad().getDescripcion()}" />  </td>    
                                    <td ><c:out value="${r.getFecha()}" />  </td>  
                                    <td ><c:out value="${r.getHoraDesde()}" />  </td>  
                                    <td > <a class="link1 badge badge-success" href="${pageContext.request.contextPath}/editarReserva/${r.getIdAgenda()}">  Editar </a>  <br> 
                                    <a class="link2 badge badge-warning" href="${pageContext.request.contextPath}/eliminarReserva/${r.getIdAgenda()}/${r.getPaciente().getIdPaciente()}">  Eliminar </a>  </td>                          
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
      <!-- Modal1 -->
        <div class="modal fade" id="myModal1" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"></h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body px-0">
                    </div>
                </div>
            </div>
        </div>           
        
     <!-- Modal2 -->
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog modal-sm modal-dialog-centered">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title"></h6>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-primary mx-auto w-25" id="modal-btn-si">Sí</button>
                        <button type="button" class="btn btn-outline-dark mx-auto w-25" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
        
    
    
    </main>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

$('body').on("click", '.link1', function(e) {
    e.preventDefault();
    var id = $(this).attr('href').split(/[./]/)[3];;
    $('.modal-title').html("Editar reserva ID: " + id);
    $('.modal-body').load(this.href, function () {
        $('#myModal1').modal({ show: true });
    });
});

$('body').on("click", '.link2', function(e) {
    var $self = $(this);
    e.preventDefault();
    $('.modal-title').html("¿Está seguro que desea eliminar esta reserva?");
    $('#myModal2').modal({ show: true });
    $("#modal-btn-si").on("click", function(){
         window.location.href = $self.attr('href');
      });
});

$(document).ready(function () {
	
    $('#tabla1').DataTable({
        "order": [[0, "asc"]],
        "columnDefs": [{ targets: 3, render: $.fn.dataTable.render.moment('YYYY-MM-DD','DD/MM/YYYY') },
            {targets: 5, orderable: false}],
        "language": { "url": "https://cdn.datatables.net/plug-ins/1.10.21/i18n/Spanish.json" }
    });

    $('#contenedor1').css("width", "100%");
    $('#contenedor1').css("margin", "0");
    $('#contenedor1').css("font-size", "0.9em");


});

</script>

</body>
</html>