# ------------------------------------------------------------------------------
# wp-scripts/init.sh
# ------------------------------------------------------------------------------

set -e

# ------------------
# Permalink settings
# ------------------

wp rewrite structure '/%postname%/'
wp rewrite flush

# --------------
# Starting pages
# --------------

# Create the "About Me" page if it doesn't already exist.
if [[ ! `wp post list --post_type=page --name=about-me --format=ids` ]]
then
  wp post create --post_type=page --post_title="About Me" --post_name=about-me \
    --post_status=publish
fi

# Create the "Privacy Policy" page if it doesn't already exist.
if [[ ! `wp post list --post_type=page --name=privacy-policy --format=ids` ]]
then
  wp post create --post_type=page --post_title="Privacy Policy"                \
    --post_name=privacy-policy --post_status=publish
fi

# The "Privacy Policy" page is created in draft when WordPress is initialized,
# so make sure that we publish it now.
wp post list --post_type=page --name=privacy-policy --format=ids               \
  | xargs wp post update --post_status=publish

wp option set show_on_front page
wp option set page_on_front                                                    \
  `wp post list --post_type=page --name=about-me --format=ids`

# ----
# Menu
# ----

wp menu list --format=ids | xargs --no-run-if-empty wp menu delete
wp menu create Primary
wp post list --post_type=page --name=about-me --format=ids                     \
  | xargs --no-run-if-empty wp menu item add-post Primary
wp post list --post_type=page --name=privacy-policy --format=ids               \
  | xargs --no-run-if-empty wp menu item add-post Primary
wp menu location assign Primary primary

# ----------------
# Theme activation
# ----------------

theme=wp-bootstrap-starter-child

wp theme install wp-bootstrap-starter --version=3.3.6
wp theme activate $theme

wp theme delete twentytwenty
wp theme delete twentytwentyone
wp theme delete twentytwentytwo
wp theme delete twentytwentythree

# ------------
# Theme images
# ------------

wp option update uploads_use_yearmonth_folders 0

images="site-header.webp site-icon.png site-logo.webp site-profile.webp"

for image in $images
do

  post_name="${image%.*}"
  wp post list --post_type=attachment --name=$post_name --format=ids           \
    | xargs --no-run-if-empty wp post delete --force
  wp media import wp-content/themes/$theme/assets/img/$image

done

wp option update uploads_use_yearmonth_folders 1

# ------------------------
# Theme mods and site icon
# ------------------------

wp theme mod set header_image /wp-content/uploads/site-header.webp
wp theme mod set wp_bootstrap_starter_logo /wp-content/uploads/site-logo.webp
wp theme mod set header_banner_title_setting "David Williamson"
wp theme mod set header_banner_tagline_setting \
"Bringing people together in harnessing technology to solve problems and \
achieve goals"
wp theme mod set theme_option_setting flatly
wp option set site_icon                                                        \
  `wp post list --post_type=attachment --name=site-icon --format=ids`

# --------------
# Footer widgets
# --------------

# footer-1

wp widget list footer-1 --format=ids | xargs --no-run-if-empty wp widget delete

title="David Williamson"

# mailto
content="<p><a href=\"mailto:david.williamson@varilink.co.uk\">"
content="${content}<i class=\"far fa-envelope\"></i>&nbsp;&nbsp;"
content="${content}david.williamson@varilink.co.uk</a></p>"

# LinkedIn
content="${content}<p><a href=\"https://www.linkedin.com/in/davidwilliamson6\""
content="${content} target=\"_blank\"><i class=\"fab fa-linkedin-in\"></i>"
content="${content}&nbsp;&nbsp;davidwilliamson6</a></p>"

# GitHub
content="${content}<p><a href=\"https://github.com/varilink\" target="
content="${content}\"_blank\"><i class=\"fab fa-github\"></i>&nbsp;&nbsp;"
content="${content}varilink</a></p>"

wp widget add custom_html footer-1 --title="$title" --content="$content"

# footer-2

wp widget list footer-2 --format=ids | xargs --no-run-if-empty wp widget delete

title="Varilink Computing Ltd"

content="<p>10 Hitchen Road<br>Long Eaton<br>Nottingham NG10 3SB</p>"
content="${content}<p>Registered in England and Wales, Company No. 03121510</p>"
content="${content}<p>VAT Registration No. 346074696</p>"

wp widget add custom_html footer-2 --title="$title" --content="$content"

# footer-3

wp widget list footer-3 --format=ids | xargs --no-run-if-empty wp widget delete

title="Data Protection"

content="<p>See our <a href=\"/privacy-policy\">Privacy Policy</a></p>"

wp widget add custom_html footer-3 --title="$title" --content="$content"
