require(["gitbook", "lodash", "jQuery"], function(gitbook, _, $) {
    var index = null;
    var $searchInput, $searchForm;
    var $highlighted, hi = 0, hiOpts = { className: 'search-highlight' };
    var collapse = false;

    // Use a specific index
    function loadIndex(data) {
        // [Yihui] In bookdown, I use a character matrix to store the chapter
        // content, and the index is dynamically built on the client side.
        // Gitbook prebuilds the index data instead: https://github.com/GitbookIO/plugin-search
        // We can certainly do that via R packages V8 and jsonlite, but let's
        // see how slow it really is before improving it. On the other hand,
        // lunr cannot handle non-English text very well, e.g. the default
        // tokenizer cannot deal with Chinese text, so we may want to replace
        // lunr with a dumb simple text matching approach.
        index = lunr(function () {
          this.ref('url');
          this.field('title', { boost: 10 });
          this.field('body');
        });
        data.map(function(item) {
          index.add({
            url: item[0],
            title: item[1],
            body: item[2]
          });
        });
    }

    // Fetch the search index
    function fetchIndex() {
        return $.getJSON(gitbook.state.basePath+"/search_index.json")
                .then(loadIndex);  // [Yihui] we need to use this object later
    }

    // Search for a term and return results
    function search(q) {
        if (!index) return;

        var results = _.chain(index.search(q))
        .map(function(result) {
            var parts = result.ref.split("#");
            return {
                path: parts[0],
                hash: parts[1]
            };
        })
        .value();

        // [Yihui] Highlight the search keyword on current page
        hi = 0;
        $highlighted = results.length === 0 ? undefined : $('.page-inner')
          .unhighlight(hiOpts).highlight(q, hiOpts).find('span.search-highlight');
        scrollToHighlighted();
        toggleTOC(results.length > 0);

        return results;
    }

    // [Yihui] Scroll the chapter body to the i-th highlighted string
    function scrollToHighlighted() {
      if (!$highlighted) return;
      var n = $highlighted.length;
      if (n === 0) return;
      var $p = $highlighted.eq(hi), p = $p[0], rect = p.getBoundingClientRect();
      if (rect.top < 0 || rect.bottom > $(window).height()) {
        ($(window).width() >= 1240 ? $('.body-inner') : $('.book-body'))
          .scrollTop(p.offsetTop - 100);
      }
      $highlighted.css('background-color', '');
      // an orange background color on the current item and removed later
      $p.css('background-color', 'orange');
      setTimeout(function() {
        $p.css('background-color', '');
      }, 2000);
    }

    // [Yihui] Expand/collapse TOC
    function toggleTOC(show) {
      if (!collapse) return;
      var toc_sub = $('ul.summary').children('li[data-level]').children('ul');
      if (show) return toc_sub.show();
      var href = window.location.pathname;
      href = href.substr(href.lastIndexOf('/') + 1);
      if (href === '') href = 'index.html';
      var li = $('a[href^="' + href + location.hash + '"]').parent('li.chapter').first();
      toc_sub.hide().parent().has(li).children('ul').show();
      li.children('ul').show();
    }

    // Create search form
    function createForm(value) {
        if ($searchForm) $searchForm.remove();
        if ($searchInput) $searchInput.remove();

        $searchForm = $('<div>', {
            'class': 'book-search',
            'role': 'search'
        });

        $searchInput = $('<input>', {
            'type': 'search',
            'class': 'form-control',
            'val': value,
            'placeholder': 'Type to search'
        });

        $searchInput.appendTo($searchForm);
        $searchForm.prependTo(gitbook.state.$book.find('.book-summary'));
    }

    // Return true if search is open
    function isSearchOpen() {
        return gitbook.state.$book.hasClass("with-search");
    }

    // Toggle the search
    function toggleSearch(_state) {
        if (isSearchOpen() === _state) return;
        if (!$searchInput) return;

        gitbook.state.$book.toggleClass("with-search", _state);

        // If search bar is open: focus input
        if (isSearchOpen()) {
            gitbook.sidebar.toggle(true);
            $searchInput.focus();
        } else {
            $searchInput.blur();
            $searchInput.val("");
            gitbook.storage.remove("keyword");
            gitbook.sidebar.filter(null);
            $('.page-inner').unhighlight(hiOpts);
            toggleTOC(false);
        }
    }

    // Recover current search when page changed
    function recoverSearch() {
        var keyword = gitbook.storage.get("keyword", "");

        createForm(keyword);

        if (keyword.length > 0) {
            if(!isSearchOpen()) {
                toggleSearch(true); // [Yihui] open the search box
            }
            gitbook.sidebar.filter(_.pluck(search(keyword), "path"));
        }
    }


    gitbook.events.bind("start", function(e, config) {
        // [Yihui] disable search
        if (config.search === false) return;
        collapse = !config.toc || config.toc.collapse === 'section' ||
          config.toc.collapse === 'subsection';

        // Pre-fetch search index and create the form
        fetchIndex()
        // [Yihui] recover search after the page is loaded
        .then(recoverSearch);


        // Type in search bar
        $(document).on("keyup", ".book-search input", function(e) {
            var key = (e.keyCode ? e.keyCode : e.which);
            // [Yihui] Escape -> close search box; Up/Down: previous/next highlighted
            if (key == 27) {
                e.preventDefault();
                toggleSearch(false);
            } else if (key == 38) {
              if (hi <= 0 && $highlighted) hi = $highlighted.length;
              hi--;
              scrollToHighlighted();
            } else if (key == 40) {
              hi++;
              if ($highlighted && hi >= $highlighted.length) hi = 0;
              scrollToHighlighted();
            }
        }).on("input", ".book-search input", function(e) {
            var q = $(this).val().trim();
            if (q.length === 0) {
                gitbook.sidebar.filter(null);
                gitbook.storage.remove("keyword");
                $('.page-inner').unhighlight(hiOpts);
                toggleTOC(false);
            } else {
                var results = search(q);
                gitbook.sidebar.filter(
                    _.pluck(results, "path")
                );
                gitbook.storage.set("keyword", q);
            }
        });

        // Create the toggle search button
        gitbook.toolbar.createButton({
            icon: 'fa fa-search',
            label: 'Search',
            position: 'left',
            onClick: toggleSearch
        });

        // Bind keyboard to toggle search
        gitbook.keyboard.bind(['f'], toggleSearch);
    });

    // [Yihui] do not try to recover search; always start fresh
    // gitbook.events.bind("page.change", recoverSearch);
});
