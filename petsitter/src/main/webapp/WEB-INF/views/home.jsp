<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>



<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="resources/images/4.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="resources/images/2.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="resources/images/3.png" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="resources/images/1.png" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<%@ include file="includes/footer.jsp"%>