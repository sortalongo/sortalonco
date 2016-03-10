const makeSticky = (element) => {
  const regex = /sticky-top|sticky-left|sticky-bottom|sticky-right/g
  const removeSticky = () => {
    element.className = element.className.replace(regex , '')
  }
  removeSticky()

  const rect = element.getBoundingClientRect()

  const top = rect.top + window.pageYOffset
  const bottom = rect.bottom + window.pageYOffset
  const left = rect.left + window.pageXOffset
  const right = rect.right + window.pageXOffset


  const scrollFn = (event) => {

    const isSticky = element.className.match(regex)
    if (window.pageYOffset > top) {
      if (!isSticky) { element.className += " sticky-top" }
    } else if (window.pageXOffset > left) {
      if (!isSticky) { element.className += " sticky-left" }
    } else if (window.pageYOffset + window.innerHeight < bottom) {
      if (!isSticky) { element.className += " sticky-bottom" }
    } else if (window.pageXOffset + window.innerWidth < right) {
      if (!isSticky) { element.className += " sticky-right" }
    } else {
      removeSticky()
    }
  }
  document.addEventListener("scroll", scrollFn)
}
