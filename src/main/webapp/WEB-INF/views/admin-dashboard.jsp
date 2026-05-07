<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Admin dashboard"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>

<main class="container-fluid px-lg-4 pb-5">
    <section class="tp-dash-banner tp-dash-banner--admin tp-animate-fade-up">
        <i class="bi bi-globe-americas tp-dash-decor" aria-hidden="true"></i>
        <div class="tp-dash-banner-inner">
            <p class="text-uppercase small fw-semibold mb-1 opacity-75">Governance skyline</p>
            <h2 class="display-6 fw-bold mb-2">Admin mission control</h2>
            <p class="mb-0 opacity-90"><i class="bi bi-person-check me-1"></i>${admin.fullName}</p>
        </div>
    </section>

    <header class="tp-page-header d-flex flex-wrap justify-content-between align-items-start gap-3 mb-4">
        <div>
            <h1 class="h2 mb-1">Live metrics</h1>
            <p class="text-secondary mb-0">Cards animate in softly—figures stream from your textual data stores.</p>
        </div>
        <div class="d-flex flex-wrap gap-2">
            <a class="btn btn-primary btn-sm rounded-pill px-3 tp-glass-rise" href="${pageContext.request.contextPath}/packages/new"><i class="bi bi-plus-lg me-1"></i>New package</a>
            <a class="btn btn-outline-secondary btn-sm rounded-pill px-3" href="${pageContext.request.contextPath}/admin/staff/list"><i class="bi bi-people me-1"></i>Staff</a>
        </div>
    </header>

    <div class="row g-3 g-xl-4 mb-4">
        <div class="col-6 col-xl-3">
            <div class="card tp-stat-card tp-pop tp-delay-1 border-0 h-100 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-semibold mb-1">Users</p>
                    <h2 class="h3 fw-bold mb-2">${userCount}</h2>
                    <a class="stretched-link text-decoration-none small fw-semibold" href="${pageContext.request.contextPath}/users/list">Manage travelers <i class="bi bi-arrow-right"></i></a>
                    <i class="bi bi-people stat-icon text-primary"></i>
                </div>
            </div>
        </div>
        <div class="col-6 col-xl-3">
            <div class="card tp-stat-card tp-pop tp-delay-2 border-0 h-100 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-semibold mb-1">Bookings</p>
                    <h2 class="h3 fw-bold mb-2">${bookingCount}</h2>
                    <a class="stretched-link text-decoration-none small fw-semibold" href="${pageContext.request.contextPath}/bookings">Open queue <i class="bi bi-arrow-right"></i></a>
                    <i class="bi bi-calendar-check stat-icon text-primary"></i>
                </div>
            </div>
        </div>
        <div class="col-6 col-xl-3">
            <div class="card tp-stat-card tp-pop tp-delay-3 border-0 h-100 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-semibold mb-1">Packages</p>
                    <h2 class="h3 fw-bold mb-2">${packageCount}</h2>
                    <a class="stretched-link text-decoration-none small fw-semibold" href="${pageContext.request.contextPath}/packages/list">Catalog <i class="bi bi-arrow-right"></i></a>
                    <i class="bi bi-suitcase-lg stat-icon text-primary"></i>
                </div>
            </div>
        </div>
        <div class="col-6 col-xl-3">
            <div class="card tp-stat-card tp-pop tp-delay-4 border-0 h-100 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-semibold mb-1">Destinations</p>
                    <h2 class="h3 fw-bold mb-2">${destinationCount}</h2>
                    <a class="stretched-link text-decoration-none small fw-semibold" href="${pageContext.request.contextPath}/destinations/list">Explore <i class="bi bi-arrow-right"></i></a>
                    <i class="bi bi-geo-alt stat-icon text-primary"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card border-0 h-100 tp-glass-rise tp-animate-fade-up tp-delay-2">
                <div class="card-body p-4">
                    <h2 class="h5 fw-bold mb-3"><i class="bi bi-pie-chart me-2 text-primary"></i>Operations snapshot</h2>
                    <ul class="list-group list-group-flush rounded-3 border">
                        <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                            <span><i class="bi bi-people-fill me-2 text-secondary"></i>Staff members</span>
                            <span class="badge bg-primary rounded-pill">${staffCount}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                            <span><i class="bi bi-chat-heart me-2 text-secondary"></i>Feedback records</span>
                            <span class="badge bg-primary rounded-pill">${feedbackCount}</span>
                        </li>
                    </ul>
                    <div class="d-flex flex-wrap gap-2 mt-3">
                        <a class="btn btn-outline-primary btn-sm rounded-pill" href="${pageContext.request.contextPath}/admin/staff/list">Staff CRUD</a>
                        <a class="btn btn-outline-primary btn-sm rounded-pill" href="${pageContext.request.contextPath}/feedback/list">Feedback</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card border-0 h-100 tp-glass-rise tp-animate-fade-up tp-delay-3">
                <div class="card-body p-4">
                    <h2 class="h5 fw-bold mb-3"><i class="bi bi-lightning-charge me-2 text-warning"></i>Quick actions</h2>
                    <div class="d-grid gap-2">
                        <a class="btn btn-primary rounded-3 py-3 text-start" href="${pageContext.request.contextPath}/users/new"><i class="bi bi-person-plus me-2"></i>Add traveler record</a>
                        <a class="btn btn-outline-primary rounded-3 py-3 text-start" href="${pageContext.request.contextPath}/destinations/new"><i class="bi bi-geo-alt-fill me-2"></i>Register destination</a>
                        <a class="btn btn-outline-secondary rounded-3 py-3 text-start" href="${pageContext.request.contextPath}/feedback/new"><i class="bi bi-pencil-square me-2"></i>Log testimonial</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
