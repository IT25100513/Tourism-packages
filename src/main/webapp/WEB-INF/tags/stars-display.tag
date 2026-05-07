<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ attribute name="rating" required="true" type="java.lang.Integer" %>
<c:set var="r" value="${rating lt 1 ? 0 : (rating gt 5 ? 5 : rating)}"/>
<span class="tp-stars-display text-nowrap" role="img" aria-label="${r} out of 5 stars">
<c:forEach begin="1" end="5" var="s">
<c:choose><c:when test="${s le r}">
<i class="bi bi-star-fill text-warning tp-star-display"></i>
</c:when><c:otherwise>
<i class="bi bi-star tp-star-display tp-star-muted"></i>
</c:otherwise></c:choose>
</c:forEach>
</span>
