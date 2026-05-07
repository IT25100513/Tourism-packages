<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="My trips"/>
    </jsp:include>
</head>
<body class="page-customer pb-5">
<jsp:include page="/WEB-INF/views/fragments/customer-nav.jsp"/>

<div class="container pb-5">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <h1 class="h3 fw-bold text-page-title mb-1">Hi, ${user.fullName}</h1>
            <p class="text-page-sub mb-0 small">Track requests and confirmations in one glance.</p>
        </div>
        <a class="btn btn-primary rounded-pill px-4 fw-semibold" href="${pageContext.request.contextPath}/bookings/new"><i class="bi bi-plus-lg me-1"></i>New booking</a>
    </div>

    <div class="tp-content-card tp-glass-rise tp-animate-fade-up">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="table-light">
                    <tr><th>Package</th><th class="text-end">Price</th><th>Status</th><th>Trip starts</th><th>Notes</th></tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty bookings}">
                            <tr><td colspan="5"><div class="tp-empty py-5"><i class="bi bi-calendar-plus"></i>Nothing booked yet—start with a shiny new itinerary!</div></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${bookings}">
                                <c:set var="packageName" value="Package removed"/>
                                <c:set var="rowPrice" value="${null}"/>
                                <c:forEach var="p" items="${packages}">
                                    <c:if test="${p.id eq b.packageId}">
                                        <c:set var="packageName" value="${p.name}"/>
                                        <c:set var="rowPrice" value="${p.price}"/>
                                    </c:if>
                                </c:forEach>
                                <tr>
                                    <td class="fw-semibold">${packageName}</td>
                                    <td class="text-end font-monospace small">
                                        <c:choose>
                                            <c:when test="${packageName eq 'Package removed'}">—</c:when>
                                            <c:otherwise><vh:price-lkr value="${rowPrice}"/></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status eq 'COMPLETED'}"><span class="badge text-bg-dark rounded-pill">${b.status}</span></c:when>
                                            <c:when test="${b.status eq 'CONFIRMED'}"><span class="badge text-bg-success rounded-pill">${b.status}</span></c:when>
                                            <c:when test="${b.status eq 'CANCELLED'}"><span class="badge text-bg-secondary rounded-pill">${b.status}</span></c:when>
                                            <c:otherwise><span class="badge text-bg-warning text-dark rounded-pill">${b.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small">${b.bookingDate}</td>
                                    <td class="small text-secondary">${empty b.notes ? '—' : b.notes}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
