<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-dark tp-navbar sticky-top py-3 mb-4">
  <div class="container-fluid px-lg-4">
    <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
      <i class="bi bi-grid-1x2-fill opacity-75"></i>
      <span>Admin console</span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#admNav" aria-controls="admNav" aria-expanded="false" aria-label="Menu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="admNav">
      <ul class="navbar-nav flex-wrap me-auto mb-2 mb-lg-0 py-lg-0">
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/admin/staff/list"><i class="bi bi-people me-1"></i>Staff</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/users/list"><i class="bi bi-person-lines-fill me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/packages/list"><i class="bi bi-suitcase-lg me-1"></i>Packages</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/bookings"><i class="bi bi-calendar-check me-1"></i>Bookings</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/destinations/list"><i class="bi bi-geo-alt me-1"></i>Destinations</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/feedback/list"><i class="bi bi-chat-heart me-1"></i>Feedback</a></li>
      </ul>
      <div class="d-flex flex-wrap align-items-center gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="${pageContext.request.contextPath}/"><i class="bi bi-house me-1"></i>Site</a>
        <a class="btn btn-light btn-sm rounded-pill px-3 text-dark fw-semibold" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
      </div>
    </div>
  </div>
</nav>
