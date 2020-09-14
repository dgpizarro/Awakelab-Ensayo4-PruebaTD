<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Ingreso Reserva</title>
<!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Jquery Ui Style -->  
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<style type="text/css">
    div.ui-datepicker {
            font-size: 0.9em;
        }
        
    input[type="date"]::-webkit-inner-spin-button,
    input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
    }
</style>
   
</head>
<body class="bg-light">

    <input id="next" type="hidden" value="${next}">
    
     <nav class="navbar navbar-expand-md navbar-dark bg-primary fixed-top">
        <span class="navbar-brand" >Clínica El Vacunazo</span>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
            aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item ">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index">Listado </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/ingresarReserva">Reservas <span class="sr-only">(current)</span></a>
                </li>
            </ul>
        </div>
    </nav>


    <main role="main" class="container py-5">
    
        <div class="pt-5 text-center">
            <h3>Reserva de horas médicas</h3>
        </div>
                
         <div class="row pt-4">
            <div class="col-12 col-md-8 mx-auto">         
            
            <c:if test="${param.alert == true}">
            <div class="alert alert-danger alert-dismissible fade show my-4" role="alert">
                   Ha ocurrido un error en la transacción.
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
            </div>
            </c:if>
                                    
                <form:form  class="needs-validation" novalidate="true" action="${pageContext.request.contextPath}/reservarHora" method="POST">
                
                      <div class="form-group">
                        <label for="entrada1">Nombre Paciente</label>
                        <form:input path="paciente.nombre" class="form-control" id="entrada1" maxlength="50" required="true"/>
                        <div class="invalid-feedback">
                        Nombre requerido
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="entrada2">Apellido Paciente</label>
                        <form:input path="paciente.apellido" class="form-control" id="entrada2" maxlength="50" required="true"/>
                        <div class="invalid-feedback">
                        Apellido requerido
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label for="entrada3">Rut Paciente </label>
                        <form:input path="paciente.rutPaciente" class="form-control" id="entrada3" maxlength="11" required="true"/>
                        <div class="invalid-feedback">
                        Apellido requerido
                        </div>
                      </div>
                      
                       <div class="form-group">
                            <label for="select1">Especialiad</label>
                            <select class="custom-select" id="select1" name="select1" onchange="buscarDoctores(this);" required>
                                <option selected disabled value="">Seleccione especialidad</option>
                                <c:forEach var="e" items="${especialiades}">
                                     <option value="${e.getIdEspecialidad()}"> <c:out value="${e.getDescripcion()}"/></option>
                                 </c:forEach>                                        
                            </select>
                            <div class="invalid-feedback">
                            </div>
                      </div>    
                      
                      <div class="form-group" >
                            <label for="select2">Doctor(a)</label>
                            <form:select class="custom-select" id="select2" path="doctor.idDoctor" required="true" >
                              <option selected disabled value="">Seleccione doctor</option>
                            </form:select>
                            <div class="invalid-feedback">
                            </div>
                      </div>    
                      
                      <div class="form-group">
                        <label for="entrada4">Fecha </label>
                        <form:input path="fecha" type="date" class="form-control datepicker" id="entrada4" required="true" placeholder="dd-mm-aaaa" />
                        <div class="invalid-feedback">
                        </div>
                      </div>
                      
                       <div class="form-group">
                        <label for="entrada4">Hora </label>
                        <form:input type="time" path="horaDesde" class="form-control" id="entrada5" required="true"/>
                        <div class="invalid-feedback">
                        </div>
                      </div>
                      
                      <button class="btn btn-primary btn-block mt-5 mb-4 shadow" type="submit">Reservar</button>                      
                      
                   </form:form>
                   
                    <hr class="mb-4">
                </div>
                </div>
        
        
          

    
    </main>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="<c:url value="/resources/js/datepicker-es.js" />" ></script>

<script type="text/javascript">

$( document ).ready(function() {	
	 $(".datepicker" ).datepicker({
		 dateFormat: "yy-mm-dd",
		 minDate: +1,
		 language: 'es'
     });
});

function buscarDoctores(select) {
   var id =  $('select').val();
    
    $.getJSON("${pageContext.request.contextPath}/api/ldoctores/" + id, function (json) {
    	$('#select2').empty();
        $('#select2').append($('<option>').text("Seleccione doctor").attr('value', '').prop('disabled', true).prop('selected', true));
        $.each(json, function (i, obj) {
            $('#select2').append($('<option>').text(obj.nombre +' ' + obj.apellido).attr('value', obj.idDoctor));
        });
    });
}

(function () {
    'use strict';
    window.addEventListener('load', function () {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function (form) {
            form.addEventListener('submit', function (event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

</script>
</body>
</html>