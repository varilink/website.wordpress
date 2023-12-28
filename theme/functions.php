<?php

// Opt-in to more opinionated styles.

add_action( 'after_setup_theme', function () {
    add_theme_support( 'align-wide' );
    add_theme_support( 'wp-block-styles' );
});

// Enqueue my theme's stylesheet in both the front-end interface.

add_action( 'wp_enqueue_scripts', function () {
    wp_enqueue_style(
        'site-theme', get_template_directory_uri() . '/style.css'
    );
});

