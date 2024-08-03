Pagy::DEFAULT[:limit] = Settings.pagy.number_items_10 # items per page
# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page
# Require a CSS framework extra in the pagy initializer (e.g. bootstrap)
require 'pagy/extras/bootstrap'
