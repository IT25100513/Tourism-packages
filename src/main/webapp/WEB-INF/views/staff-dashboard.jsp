<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Staff dashboard"/>
    </jsp:include>
</head>
<body class="page-staff">
<jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/>

<main class="container-fluid px-lg-4 pb-5">
    <section class="tp-dash-banner tp-dash-banner--staff tp-animate-fade-up">
        <i class="bi bi-compass-fill tp-dash-decor" aria-hidden="true"></i>
        <div class="tp-dash-banner-inner">
            <p class="text-uppercase small fw-semibold mb-1 opacity-75">Crew workstation</p>
            <h2 class="display-6 fw-bold mb-2">${staff.fullName}</h2>
            <p class="mb-0 opacity-90"><i class="bi bi-building me-1"></i>${staff.department} · operations deck</p>
        </div>
    </section>

    <header class="tp-page-header mb-4">
        <h1 class="h2 fw-bold mb-2">Operational pulse</h1>
        <p class="text-secondary mb-0">Metrics glide in softly—prioritize confirmations and traveler notes.</p>
    </header>

    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="card tp-pop tp-delay-1 border-0 border-start border-success border-4 rounded-3 shadow-sm h-100 overflow-hidden position-relative tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-bold mb-1">Bookings</p>
                    <h2 class="display-6 fw-bold text-success-emphasis">${bookingCount}</h2>
                    <a class="stretched-link text-decoration-none fw-semibold small" href="${pageContext.request.contextPath}/bookings">Review queue <i class="bi bi-arrow-right-short"></i></a>
                    <i class="bi bi-inbox-fill position-absolute end-0 bottom-0 m-4 display-4 text-success opacity-10"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card tp-pop tp-delay-2 border-0 shadow-sm h-100 rounded-3 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-bold mb-1">Published packages</p>
                    <h2 class="display-6 fw-bold">${packageCount}</h2>
                    <a class="stretched-link text-decoration-none fw-semibold small" href="${pageContext.request.contextPath}/staff/packages">Browse catalog <i class="bi bi-arrow-right-short"></i></a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card tp-pop tp-delay-3 border-0 shadow-sm h-100 rounded-3 tp-glass-rise">
                <div class="card-body p-4">
                    <p class="small text-uppercase text-secondary fw-bold mb-1">Destinations</p>
                    <h2 class="display-6 fw-bold">${destinationCount}</h2>
                    <a class="stretched-link text-decoration-none fw-semibold small" href="${pageContext.request.contextPath}/staff/destinations">View places <i class="bi bi-arrow-right-short"></i></a>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm rounded-3 tp-glass-rise tp-animate-fade-up tp-delay-4">
        <div class="card-body p-4 p-lg-5">
            <h2 class="h5 fw-bold mb-3"><i class="bi bi-check2-square me-2 text-success"></i>Today’s focus</h2>
            <ul class="mb-0 ps-3 text-secondary">
                <li class="mb-2">Update booking statuses so travelers get timely confirmations.</li>
                <li class="mb-2">Scan new feedback for urgent service issues.</li>
                <li>Escalate anything unusual to an administrator.</li>
            </ul>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
