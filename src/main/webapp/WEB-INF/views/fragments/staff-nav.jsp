<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-dark tp-navbar sticky-top py-3 mb-4">
  <div class="container-fluid px-lg-4">
    <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="${pageContext.request.contextPath}/staff/dashboard">
      <i class="bi bi-patch-check-fill opacity-90"></i>
      <span>Staff portal</span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#stNav" aria-label="Menu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="stNav">
      <ul class="navbar-nav flex-wrap me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/staff/dashboard"><i class="bi bi-house-door me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/staff/packages"><i class="bi bi-suitcase me-1"></i>Packages</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/staff/destinations"><i class="bi bi-map me-1"></i>Destinations</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/bookings"><i class="bi bi-list-task me-1"></i>Bookings</a></li>
        <li class="nav-item"><a class="nav-link px-3" href="${pageContext.request.contextPath}/staff/feedback"><i class="bi bi-chat-dots me-1"></i>Feedback</a></li>
      </ul>
      <a class="btn btn-light btn-sm rounded-pill px-3 text-dark fw-semibold" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
    </div>
  </div>
</nav>
