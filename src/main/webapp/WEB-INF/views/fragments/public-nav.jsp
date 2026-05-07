<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar navbar-expand-lg tp-navbar navbar-light sticky-top py-3 mb-0">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/">
      <span class="d-inline-flex align-items-center justify-content-center rounded-3 bg-white shadow-sm px-2 py-1" style="color:var(--tp-teal);">
        <i class="bi bi-airplane-fill"></i>
      </span>
      <span>VoyageHub</span>
    </a>
    <button class="navbar-toggler border-0 shadow-sm" type="button" data-bs-toggle="collapse" data-bs-target="#pubNav" aria-controls="pubNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="pubNav">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-1">
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/users/register"><i class="bi bi-person-plus me-1"></i>Register</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/users/login"><i class="bi bi-person-circle me-1"></i>Customer login</a></li>
        <li class="nav-item ms-lg-2">
          <a class="btn btn-primary btn-sm px-3" href="${pageContext.request.contextPath}/login"><i class="bi bi-shield-lock me-1"></i>Staff &amp; admin</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
