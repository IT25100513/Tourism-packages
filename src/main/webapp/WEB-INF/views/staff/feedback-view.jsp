<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Guest feedback"/>
    </jsp:include>
</head>
<body class="page-staff">
<jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5" style="max-width:900px;">
    <header class="tp-page-header mb-4">
        <h1 class="h2 fw-bold mb-1">Voices from travelers</h1>
        <p class="text-secondary mb-0 small">Accordion view · read-only for staff.</p>
    </header>

    <div class="accordion accordion-flush shadow-sm rounded-4 overflow-hidden" id="fbAccordion">
        <c:choose>
            <c:when test="${empty feedbackList}">
                <div class="bg-white p-5 text-center text-secondary rounded-4"><i class="bi bi-chat-heart display-4 d-block mb-3 opacity-25"></i>No stories yet.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="f" items="${feedbackList}">
                    <div class="accordion-item border-0">
                        <h2 class="accordion-header" id="h${f.id}">
                            <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#c${f.id}">
                                <span class="me-2 d-inline-flex align-items-center"><vh:stars-display rating="${f.rating}"/></span>
                                #${f.id} · ${f.createdAt}
                            </button>
                        </h2>
                        <div id="c${f.id}" class="accordion-collapse collapse" data-bs-parent="#fbAccordion">
                            <div class="accordion-body text-secondary small">
                                <c:choose>
                                    <c:when test="${empty f.comment}">No written comment attached.</c:when>
                                    <c:otherwise><c:out value="${f.comment}"/></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
