(function (window, document) {
  var section_template =
    document.getElementById("dbox-donation-template").innerHTML;
  document.write(section_template);
  document.write("<script src=\"https://donorbox.org/install-popup-button.js\" type=\"text/javascript\" defer><\/script>");
})(window, document);
