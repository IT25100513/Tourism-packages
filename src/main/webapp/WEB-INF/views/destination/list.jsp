<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Destinations"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header d-flex flex-wrap justify-content-between gap-3 mb-4">
        <div><h1 class="h2 fw-bold mb-1">Destinations</h1><p class="text-secondary small mb-0">Anchor every itinerary to a place.</p></div>
        <a class="btn btn-primary rounded-pill px-4" href="${pageContext.request.contextPath}/destinations/new"><i class="bi bi-pin-map me-1"></i>New place</a>
    </header>

    <div class="row g-4">
        <c:forEach var="d" items="${destinations}">
            <div class="col-lg-6 col-xxl-4">
                <div class="card border-0 shadow-sm h-100 rounded-4 overflow-hidden">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex align-items-start justify-content-between mb-2">
                            <h2 class="h5 fw-bold mb-0">${d.name}</h2>
                            <span class="badge rounded-pill bg-primary-subtle text-primary-emphasis">${d.country}</span>
                        </div>
                        <p class="text-secondary small flex-grow-1">${empty d.description ? 'No story yet.' : d.description}</p>
                        <div class="btn-group mt-3">
                            <a class="btn btn-sm btn-outline-primary rounded-pill" href="${pageContext.request.contextPath}/destinations/detail?id=${d.id}">View</a>
                            <a class="btn btn-sm btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/destinations/edit?id=${d.id}">Edit</a>
                            <a class="btn btn-sm btn-outline-danger rounded-pill" href="${pageContext.request.contextPath}/destinations/delete?id=${d.id}" onclick="return confirm('Delete destination?');">Delete</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty destinations}">
            <div class="col-12"><div class="tp-empty rounded-4 bg-white shadow-sm"><i class="bi bi-globe-americas"></i>No destinations configured.</div></div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
