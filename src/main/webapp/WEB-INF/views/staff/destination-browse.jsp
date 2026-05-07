<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Destinations"/>
    </jsp:include>
</head>
<body class="page-staff">
<jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header mb-4"><h1 class="h2 fw-bold mb-1">Destinations</h1><p class="text-secondary mb-0 small">Stories behind every pin on our map.</p></header>

    <div class="row g-4">
        <c:forEach var="d" items="${destinations}">
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 h-100 border-start border-success border-4 overflow-hidden">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-start justify-content-between gap-2 mb-3">
                            <h2 class="h4 fw-bold mb-0">${d.name}</h2>
                            <span class="badge rounded-pill bg-success-subtle text-success-emphasis border">${d.country}</span>
                        </div>
                        <p class="text-secondary small mb-0 lh-lg">${empty d.description ? 'Story coming soon.' : d.description}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty destinations}">
            <div class="col"><div class="tp-empty rounded-4 bg-white shadow-sm"><i class="bi bi-map"></i>No destinations uploaded.</div></div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
