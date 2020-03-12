<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="../inc/top.jsp" %>   
  <!-- Page Content -->
  <div class="container">

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3">Welcome
      <small style="color: rgb(0 153 174)"> ${sessionScope.userid }!</small>
    </h1>

    <!-- Content Row -->
    <div class="row">
      <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4">
        <div class="list-group">
          <a href="#" class="list-group-item">Home</a>
          <a href="#" class="list-group-item">About</a>
          <a href="#" class="list-group-item">Services</a>
          <a href="#" class="list-group-item">Contact</a>
          <a href="#" class="list-group-item">1 Column Portfolio</a>
          <a href="#" class="list-group-item">2 Column Portfolio</a>
          <a href="#" class="list-group-item">3 Column Portfolio</a>
          <a href="#" class="list-group-item">4 Column Portfolio</a>
          <a href="#" class="list-group-item">Single Portfolio Item</a>
          <a href="#" class="list-group-item">Blog Home 1</a>
          <a href="#" class="list-group-item">Blog Home 2</a>
          <a href="#" class="list-group-item">Blog Post</a>
          <a href="#" class="list-group-item">Full Width Page</a>
          <a href="#" class="list-group-item active">Sidebar Page</a>
          <a href="#" class="list-group-item">FAQ</a>
          <a href="#" class="list-group-item">404</a>
          <a href="#" class="list-group-item">Pricing Table</a>
        </div>
      </div>
      <!-- Content Column -->
      <div class="col-lg-9 mb-4">
        <h2>Section Heading</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Soluta, et temporibus, facere perferendis veniam beatae non debitis, numquam blanditiis necessitatibus vel mollitia dolorum laudantium, voluptate dolores iure maxime ducimus fugit.</p>
      </div>
    </div>
    <!-- /.row -->
<%@include file="../inc/bottom.jsp" %>