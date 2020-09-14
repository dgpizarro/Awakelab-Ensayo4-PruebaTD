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
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
        
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
            <div class="col-12 col-lg-8 mx-auto">
            <h4 class="mb-3" id="titD"> Datos médico</h4>
                <form id="especialidad" class="needs-validation" novalidate action="${pageContext.request.contextPath}/seleccionarEspecialidad" method="GET" >
                     <div class="form-group">
	                        <label for="select1">Especialiad</label>
	                        <select class="custom-select" id="select1" name="select1" required>
	                            <option selected disabled value="">Seleccione especialidad</option>
	                            <c:forEach var="e" items="${especialiades}">
	                                 <option value="${e.getIdEspecialidad()}"> <c:out value="${e.getDescripcion()}"/></option>
	                             </c:forEach>                                        
	                        </select>
	                        <div class="invalid-feedback">
                            </div>
                      </div>        
                      <button class="btn btn-primary btn-block my-4" type="submit">Siguiente</button>
                </form>
                
                 <form id="doctor" class="d-none" action="${pageContext.request.contextPath}/seleccionarDoctor" method="GET" >
                      <div class="form-group" >
	                        <label for="select2">Doctor(a)</label>
	                        <select class="form-control" id="select2" name="select2" required >
	                         <option selected disabled value="">Seleccione doctor(a)</option>
	                            <c:forEach var="d" items="${doctores}">
	                                 <option value="${d.getIdDoctor()}"> <c:out value="${d.getNombre()}"/>&nbsp;<c:out value="${d.getApellido()}"/> </option>
	                             </c:forEach>  
	                        </select>
                      </div>
                    <div class="row my-4">
                        <div class="col-6 text-center"> 
                            <a href="${pageContext.request.contextPath}/ingresarReserva">  Volver </a>
                        </div>
                        <div class="col-6"> 
                            <button class="btn btn-primary btn-block" type="submit">Siguiente</button>
                        </div>
                    </div>
                </form>
                
                 <h4 class="mb-3 d-none" id="titP"> Datos paciente</h4>
                <form:form class="d-none" id="paciente" style="width: 100%;" action="${pageContext.request.contextPath}/reservarHora" method="POST">
                
                      <form:input path="doctor.idDoctor" value="${idoc}" type="hidden" />
                
                      <div class="form-group">
                        <label for="entrada1">Nombre </label>
                        <form:input path="paciente.nombre" class="form-control" id="entrada1" maxlength="50"/>
                      </div>
                      
                      <div class="form-group">
                        <label for="entrada2">Apellido </label>
                        <form:input path="paciente.apellido" class="form-control" id="entrada2" maxlength="50"/>
                      </div>
                      
                      <div class="form-group">
                        <label for="entrada3">Rut </label>
                        <form:input path="paciente.rutPaciente" class="form-control" id="entrada3" maxlength="11"/>
                      </div>
                      
                      <hr class="mt-5">
                      
                       <div class="form-group">
                        <label for="entrada4">Fecha </label>
                        <form:input type="date" path="fecha" class="form-control" id="entrada4" maxlength="11"/>
                      </div>
                      
                       <div class="form-group">
                        <label for="entrada4">Hora </label>
                        <form:input type="time" path="horaDesde" class="form-control" id="entrada4" maxlength="11"/>
                      </div>
                      
                     <div class="row my-4">
                        <div class="col-6"> 
                            <a href="${pageContext.request.contextPath}/ingresarReserva"> <p class="text-center"> Volver </p></a>
                        </div>
                        <div class="col-6"> 
                            <button class="btn btn-primary btn-block" type="submit">Reservar</button>
                        </div>
                    </div>
                      
                      
                   </form:form>
                
            <hr class="mb-4">
            
             
		        </div>
		        </div>
        
        
        <form action="">
        <p>Nombre</p>
        <input type="text">
        <select class="custom-select" name="prueba" id="prueba">
              <option selected disabled value="">Seleccione especialidad</option>
        </select>
        </form>

    
    </main>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(document).ready(function () {

	 var next = $("#next").val();
	    if (next === "next") {
	     $('#especialidad').addClass("d-none");
	     $('#doctor').toggleClass("d-block");
	   }
	    
	    if (next === "next2") {
	     $('#titD').addClass("d-none");
         $('#especialidad').addClass("d-none");
         $('#titP').toggleClass("d-block");
         $('#paciente').toggleClass("d-block");
         
       } 

	    $.getJSON("http://localhost:8085/ensayo4/lesp", function (json) {
            $.each(json, function (i, obj) {
                $('#prueba').append($('<option>').text(obj.descripcion).attr('value', obj.idEspecialidad));
            });
        });
	    
});

(function () {
    'use strict';
    window.addEventListener('load', function () {
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.getElementsByClassName('needs-validation');
        // Loop over them and prevent submission
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