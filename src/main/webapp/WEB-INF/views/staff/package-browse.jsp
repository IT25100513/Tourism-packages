<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Packages"/>
    </jsp:include>
</head>
<body class="page-staff">
<jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header mb-4"><h1 class="h2 fw-bold mb-1">Package catalog</h1><p class="text-secondary mb-0 small"><i class="bi bi-eye me-1"></i>Read-only view for concierge teams.</p></header>

    <div class="row g-4">
        <c:forEach var="pkg" items="${packages}">
            <c:set var="destLabel" value="Unassigned"/>
            <c:forEach var="d" items="${destinations}">
                <c:if test="${d.id eq pkg.destinationId}"><c:set var="destLabel" value="${d.name}, ${d.country}"/></c:if>
            </c:forEach>
            <div class="col-lg-6 col-xxl-4">
                <div class="card border-0 shadow-sm h-100 rounded-4" style="transition:transform .2s ease;">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h2 class="h5 fw-bold mb-0 pe-2">${pkg.name}</h2>
                            <span class="badge rounded-pill text-bg-success align-self-start">${pkg.durationDays}d</span>
                        </div>
                        <p class="small text-muted mb-2"><i class="bi bi-geo-alt me-1"></i>${destLabel}</p>
                        <p class="text-secondary flex-grow-1 small">${empty pkg.description ? 'Marketing copy unavailable.' : pkg.description}</p>
                        <div class="fw-bold fs-5 text-success-emphasis font-monospace"><vh:price-lkr value="${pkg.price}"/></div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty packages}">
            <div class="col-12"><div class="tp-empty rounded-4 bg-white shadow-sm"><i class="bi bi-suitcase"></i>No packages configured yet.</div></div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
