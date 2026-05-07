<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Discover your next journey"/>
    </jsp:include>
</head>
<body class="page-public d-flex flex-column min-vh-100">
<span class="tp-trail position-fixed" style="top:120px;left:8%;z-index:0;" aria-hidden="true"></span>
<jsp:include page="/WEB-INF/views/fragments/public-nav.jsp"/>

<main class="container flex-grow-1 py-4 py-lg-5">
    <section class="tp-hero p-4 p-lg-5 mb-5 tp-glass-rise">
        <span class="position-absolute top-0 end-0 m-4 opacity-50 d-none d-xl-block tp-float" aria-hidden="true">
            <i class="bi bi-compass display-4" style="color:var(--tp-teal);"></i>
        </span>
        <div class="row align-items-center g-4 g-xl-5">
            <div class="col-lg-7">
                <span class="tp-hero-badge tp-animate-fade-up"><i class="bi bi-stars"></i> File-based Spring Boot demo</span>
                <h1 class="display-5 fw-bold mb-3 tp-animate-fade-up tp-delay-1">
                    Tourism packages,
                    <span style="background:linear-gradient(120deg,var(--tp-teal),var(--tp-teal-dark));-webkit-background-clip:text;background-clip:text;color:transparent;">crafted</span>
                    for every traveler
                </h1>
                <p class="lead text-secondary mb-4 tp-animate-fade-up tp-delay-2">
                    Plan journeys, orchestrate bookings, and gather glowing reviews—beautifully simple MVC with data in plain-text rows.
                </p>
                <div class="d-flex flex-wrap gap-2 gap-md-3 tp-animate-fade-up tp-delay-3">
                    <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/users/register"><i class="bi bi-person-plus me-2"></i>Create account</a>
                    <a class="btn btn-outline-primary btn-lg" href="${pageContext.request.contextPath}/users/login"><i class="bi bi-box-arrow-in-right me-2"></i>Customer sign in</a>
                    <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/login"><i class="bi bi-shield-lock me-2"></i>Staff &amp; admin</a>
                </div>
            </div>
            <div class="col-lg-5 tp-animate-fade-up tp-delay-2">
                <figure class="tp-hero-media mb-0 tp-float">
                    <div class="tp-hero-ring" aria-hidden="true"></div>
                    <picture>
                        <img class="tp-hero-img tp-img-hover-zoom"
                             src="https://images.unsplash.com/photo-1488646953014-85cb44e25828?auto=format&amp;fit=crop&amp;w=960&amp;q=85"
                             width="640" height="800"
                             alt="Travel essentials: passport, sunglasses, maps and camera arranged on a desk"/>
                    </picture>
                    <figcaption class="visually-hidden">Stock photography via Unsplash for demonstration.</figcaption>
                    <span class="tp-hero-accent" aria-hidden="true"></span>
                </figure>
            </div>
        </div>
    </section>

    <section class="text-center mb-5 tp-animate-fade-up tp-delay-3">
        <p class="text-secondary small mb-2 text-uppercase fw-bold" style="letter-spacing:.12em;">Why teams pick VoyageHub</p>
        <h2 class="h4 fw-bold mb-1">Motion-forward dashboards • Responsive bliss • Icon-forward cues</h2>
        <p class="small text-muted mb-0">Hover cards, glide through flows, celebrate every itinerary.</p>
    </section>

    <section class="row g-4 mb-4">
        <div class="col-md-4">
            <article class="tp-feature-card tp-feature-card--visual tp-glass-rise h-100">
                <div class="tp-feature-visual tp-bg-traveler" role="presentation"></div>
                <div class="tp-feature-body">
                    <div class="icon-wrap bg-info bg-opacity-10 text-info"><i class="bi bi-heart"></i></div>
                    <h5 class="fw-bold mb-2">Travelers</h5>
                    <p class="text-secondary small mb-3">Register instantly, tailor bookings, capture memories through feedback loops.</p>
                    <a class="fw-semibold text-decoration-none" href="${pageContext.request.contextPath}/users/register" style="color:var(--tp-teal-dark);">Start exploring <i class="bi bi-arrow-right-short"></i></a>
                </div>
            </article>
        </div>
        <div class="col-md-4">
            <article class="tp-feature-card tp-feature-card--visual tp-glass-rise h-100">
                <div class="tp-feature-visual tp-bg-staff" role="presentation"></div>
                <div class="tp-feature-body">
                    <div class="icon-wrap bg-success bg-opacity-10 text-success"><i class="bi bi-headset"></i></div>
                    <h5 class="fw-bold mb-2">Concierge teams</h5>
                    <p class="text-secondary small mb-3">Preview catalogues, glide through booking queues, empathize with traveler stories.</p>
                    <a class="fw-semibold text-decoration-none text-success" href="${pageContext.request.contextPath}/login">Enter staff portal <i class="bi bi-arrow-right-short"></i></a>
                </div>
            </article>
        </div>
        <div class="col-md-4">
            <article class="tp-feature-card tp-feature-card--visual tp-glass-rise h-100">
                <div class="tp-feature-visual tp-bg-admin" role="presentation"></div>
                <div class="tp-feature-body">
                    <div class="icon-wrap bg-warning bg-opacity-25 text-warning-emphasis"><i class="bi bi-graph-up-arrow"></i></div>
                    <h5 class="fw-bold mb-2">Administrators</h5>
                    <p class="text-secondary small mb-3">Curate master data, steward staff access, listen to every whisper of feedback.</p>
                    <a class="fw-semibold text-decoration-none text-warning-emphasis" href="${pageContext.request.contextPath}/login">Open admin cockpit <i class="bi bi-arrow-right-short"></i></a>
                </div>
            </article>
        </div>
    </section>
</main>

<footer class="tp-footer mt-auto rounded-top-4 py-4 bg-white bg-opacity-50 backdrop-blur">VoyageHub · Photos from <a href="https://unsplash.com" target="_blank" rel="noopener noreferrer" class="text-decoration-none">Unsplash</a> · coursework demo</footer>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
