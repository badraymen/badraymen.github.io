(function () {
  var pageMap = {
    "index": "_data/home.json",
    "": "_data/home.json",
    "commercial": "_data/commercial.json",
    "artistic": "_data/artistic.json",
    "bespoke": "_data/bespoke.json",
    "blog": "_data/blog.json"
  };

  var page = window.location.pathname.split("/").pop().replace(".html", "") || "";
  var dataFile = pageMap[page];

  if (!dataFile) return;

  fetch(dataFile)
    .then(function (r) { return r.json(); })
    .then(function (data) {
      // حقن النصوص باستخدام innerHTML للحفاظ على وسوم HTML
      document.querySelectorAll("[data-cms]").forEach(function (el) {
        var key = el.getAttribute("data-cms");
        if (data[key] !== undefined && data[key] !== null) {
          el.innerHTML = data[key];
        }
      });

      // تحديث عنوان الصفحة
      if (data.page_title) document.title = data.page_title;

      // حقن الصور
      document.querySelectorAll("[data-cms-img]").forEach(function (img) {
        var key = img.getAttribute("data-cms-img");
        if (data[key]) {
          img.src = data[key];
        }
      });

      // تطبيق ألوان وخطوط CSS
      if (data.home_bg_color) {
        document.documentElement.style.setProperty("--bg-color", data.home_bg_color);
      }
      if (data.accent_color) {
        document.documentElement.style.setProperty("--accent-color", data.accent_color);
      }
      if (data.body_text_color) {
        document.documentElement.style.setProperty("--text-color", data.body_text_color);
      }
      if (data.heading_font) {
        document.documentElement.style.setProperty("--heading-font", data.heading_font);
      }
      if (data.body_font) {
        document.documentElement.style.setProperty("--body-font", data.body_font);
      }
    })
    .catch(function (e) {
      console.warn("content-loader:", e);
    });
})();
