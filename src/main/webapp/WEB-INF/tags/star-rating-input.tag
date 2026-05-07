<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ attribute name="name" required="false" %>
<%@ attribute name="hiddenInputId" required="true" %>
<%@ attribute name="initialRating" required="true" type="java.lang.Integer" %>
<c:set var="fname" value="${empty name ? 'rating' : name}"/>
<c:set var="iv" value="${initialRating lt 1 ? 5 : (initialRating gt 5 ? 5 : initialRating)}"/>
<input type="hidden" name="${fname}" id="${hiddenInputId}" value="${iv}" required/>
<div class="tp-stars-input" data-tp-star-rating="" data-input-id="${hiddenInputId}" data-initial="${iv}" role="group" aria-label="Star rating">
<c:forEach begin="1" end="5" var="i">
<button type="button" class="tp-star-hit tp-star-empty" data-value="${i}" aria-label="${i} star<c:if test="${i gt 1}">s</c:if>"><i class="bi bi-star"></i></button>
</c:forEach>
</div>
