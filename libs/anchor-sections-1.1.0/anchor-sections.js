document.addEventListener('DOMContentLoaded', function () {
  // If section divs is used, we need to put the anchor in the child header
  const headers = document.querySelectorAll("div.hasAnchor.section[class*='level'] > :first-child")

  headers.forEach(function (x) {
    // Add to the header node
    if (!x.classList.contains('hasAnchor')) x.classList.add('hasAnchor')
    // Remove from the section or div created by Pandoc
    x.parentElement.classList.remove('hasAnchor')
  })
})
