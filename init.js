"use strict";

var app = window.Elm.Main.init({
  node: document.getElementById("elm")
});

// Hide our progress slider on page load.
document.onreadystatechange = function() {
  if (document.readyState === "complete") {
    document.getElementById("slider").style.display = "none";
  }
};

// Show the progress slider on navigating away or reloading the page.
// This makes it more visible that the page is reloading when you have
// the side panel with with page preview open on Glitch.
window.onbeforeunload = function() {
  document.getElementById("slider").style.display = "block";
};