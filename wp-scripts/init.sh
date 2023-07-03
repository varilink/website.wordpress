# ------------------------------------------------------------------------------
# wp-scripts/init.sh
# ------------------------------------------------------------------------------

set -e

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

wp theme mod set header_image /wp-content/uploads/site-header.webp
wp theme mod set wp_bootstrap_starter_logo /wp-content/uploads/site-logo.webp

wp option update uploads_use_yearmonth_folders 1
