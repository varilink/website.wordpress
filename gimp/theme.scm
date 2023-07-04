; ------------------------------------------------------------------------------
; gimp/theme.scm
; ------------------------------------------------------------------------------

; Gimp batch script to generate theme images from the following source files:
;
; The original filenames and download URLs are noted with each source file.

; Create linkedin-logo.jpeg and site-logo.webp. Both are based on logo.xcf but
; with a white link on a #2d3e50 background.
(let*

  (

;;; Source File:
;;; logo.svg
;;; Original Name:
;;; Originuum---Icone-link---1.0.0.svg
;;; Downloaded From:
;;; https://publicdomainvectors.org/en/free-clipart/Link-icon/45425.html

    (logoImage (car (gimp-file-load RUN-NONINTERACTIVE
      "src/logo.svg" "src/logo.svg"
    )))

    ;; Define drawable from the active and only layer in logo.svg.
    (logoLinkDrawable (car (gimp-image-get-active-layer logoImage)))

  )

;;; Output File:
;;; site-icon.png
;;; Description:
;;; Icon file for the Varilink Computing Ltd website.

  ;; Scale to the size required for site-icon.png, which is the largest output.
  (gimp-image-scale logoImage 512 512)

  (let*

    (
      ;; Work with copy of logoImage to preserve it for subsequent outputs.
      (iconLogoImage (car (gimp-image-duplicate logoImage)))
      ;; Define "Background" layer for the image.
      (bgLayer (car (gimp-layer-new iconLogoImage
        512          ; width
        512          ; height
        0            ; type (RGB-IMAGE)
        "Background" ; name
        100          ; opacity
        28           ; mode (Normal)
      )))
    )

    ;; Insert "Background" layer behind the "Link" layer.
    (gimp-image-insert-layer iconLogoImage bgLayer 0 1)

    (let*

      (
        ;; Define a drawable for the "Background" layer.
        (logoBGDrawable (car (gimp-image-get-active-layer iconLogoImage)))
      )

      ;; Set the current background colour to white.
      (gimp-context-set-background '(255.0 255.0 255.0))
      ;; Fill the "Background" layer with the background colour.
      (gimp-drawable-fill logoBGDrawable
        1 ; fill-type (Background)
      )

      ;; Save the site icon file.
      (file-png-save
        RUN-NONINTERACTIVE                    ; run-mode
        iconLogoImage                         ; image
        (car (gimp-image-merge-visible-layers
        iconLogoImage 0))                     ; drawable
        "dist/site-icon.png"                 ; filename
        "dist/site-icon.png"                 ; raw-filename
        FALSE                                 ; interlace
        9                                     ; compression
        FALSE                                 ; bkgd
        FALSE                                 ; gamma
        FALSE                                 ; offset
        FALSE                                 ; phys
        FALSE                                 ; time
      )

    )

    ;; Tidy up to avoid spurious messages on exit.
    (gimp-image-delete iconLogoImage)

  )

  ;; Scale to the size required for the LinkedIn logo file.
  (gimp-image-scale logoImage 250 250)
  ;; Change the link colour to white.
  (gimp-drawable-invert logoLinkDrawable TRUE)

  (let*

    (
      ;; Work with copy of logoImage to preserve it for subsequent outputs.
      (linkedinLogoImage (car (gimp-image-duplicate logoImage)))
      ;; Define "Background" layer for the image.
      (bgLayer (car (gimp-layer-new linkedinLogoImage
        250          ; width
        250          ; height
        0            ; type (RGB-IMAGE)
        "Background" ; name
        100          ; opacity
        28           ; mode (Normal)
      )))
    )

    ;; Insert "Background" layer behind the "Link" layer.
    (gimp-image-insert-layer linkedinLogoImage bgLayer 0 1)

    (let*

      (
        ;; Define a drawable for the "Background" layer.
        (logoBGDrawable (car (gimp-image-get-active-layer linkedinLogoImage)))
      )

      ;; Set the current background colour to #2d3e50.
      (gimp-context-set-background '(45.0 62.0 80.0))
      ;; Fill the "Background" layer with the background colour.
      (gimp-drawable-fill logoBGDrawable
        1 ; fill-type (Background)
      )

      ;; Save the LinkedIn logo file.
      (file-jpeg-save
        RUN-NONINTERACTIVE                    ; run-mode
        logoImage                             ; image
        (car (gimp-image-merge-visible-layers linkedinLogoImage 0))                 ; drawable
        "dist/linkedin-logo.jpeg"            ; filename
        "dist/linkedin-logo.jpeg"            ; raw-filename
        0.90                                  ; quality
        0                                     ; smoothing
        TRUE                                  ; optimize
        TRUE                                  ; progressive
        ""                                    ; comment
        2                                     ; subsmp (best quality)
        FALSE                                 ; baseline
        FALSE                                 ; restart
        0                                     ; dct (integer method)
      )

    )

    ;; Tidy up to avoid spurious messages on exit.
    (gimp-image-delete linkedinLogoImage)

  )

  ;; Scale to the size required for site-logo.webp.
  (gimp-image-scale logoImage 150 150)

  ;; Save the site logo file.
  (file-webp-save
    RUN-NONINTERACTIVE     ; Interactive, non-interactive
    logoImage              ; Input image
    logoLinkDrawable       ; Drawable to save
    "dist/site-logo.webp" ; The name of the file to save the image to
    "dist/site-logo.webp" ; The name entered
    0                      ; preset
    0                      ; Use lossless encoding
    90                     ; Quality of the image
    100                    ; Quality of the image's alpha channel
    0                      ; Use layers for animation
    0                      ; Loop animation infinitely
    0                      ; Minimize animation size
    0                      ; Maximum distance between key-frames
    1                      ; Toggle saving exif data
    1                      ; Toggle saving iptc data
    1                      ; Toggle saving xmp data
    0                      ; Delay
    0                      ; Force delay on all frames
  )

  ;; Tidy up to avoid spurious messages on exit.
  (gimp-image-delete logoImage)

)

(let*

  (

;;; Source File:
;;; banner.jpg
;;; Original Name:
;;; achievement-agreement-arms-bump-business-cheer-up-1431771-pxhere.com.jpg
;;; Downloaded From:
;;; https://pxhere.com/en/photo/1431771

    (bannerImage (car (
      gimp-file-load RUN-NONINTERACTIVE "src/banner.jpg" "src/banner.jpg"
    )))

    ;; Define drawable from the active and only layer in banner.jpg.
    (bannerDrawable (car (gimp-image-get-active-layer bannerImage)))

  )

  (gimp-image-crop bannerImage
    3000 750 0 508 ; width, height, offset x, offset y
  )

  (gimp-image-scale bannerImage 1400 350)

  (file-jpeg-save
    RUN-NONINTERACTIVE           ; run-mode
    bannerImage                  ; Input image
    bannerDrawable               ; Drawable to save
    "dist/linkedin-banner.jpeg" ; filename
    "dist/linkedin-banner.jpeg" ; raw-filename
    0.90                         ; quality
    0                            ; smoothing
    TRUE                         ; optimize
    TRUE                         ; progressive
    ""                           ; comment
    2                            ; subsmp (best quality)
    FALSE                        ; baseline
    FALSE                        ; restart
    0                            ; dct (integer method)
  )

  (gimp-image-scale bannerImage 1000 250)

  (gimp-drawable-brightness-contrast bannerDrawable 0.5 -0.4)
  (gimp-drawable-brightness-contrast bannerDrawable 0.5 0)

  (file-webp-save
    RUN-NONINTERACTIVE       ; Interactive, non-interactive
    bannerImage              ; Input image
    bannerDrawable           ; Drawable to save
    "dist/site-header.webp" ; The name of the file to save the image to
    "dist/site-header.webp" ; The name entered
    0                        ; preset
    0                        ; Use lossless encoding
    90                       ; Quality of the image
    100                      ; Quality of the image's alpha channel
    0                        ; Use layers for animation
    0                        ; Loop animation infinitely
    0                        ; Minimize animation size
    0                        ; Maximum distance between key-frames
    1                        ; Toggle saving exif data
    1                        ; Toggle saving iptc data
    0                        ; Toggle saving xmp data
    0                        ; Delay to use when timestamps are not available or forced
    0                        ; Force delay on all frames
  )

  (gimp-image-delete bannerImage)

)

(let*
  (
    (profileImage (car (
      gimp-file-load RUN-NONINTERACTIVE "src/profile 2022-11-23.xcf" "src/profile 2022-11-23.xcf"
    )))
  )

  (let*
    (
      (siteProfileImage (car (gimp-image-duplicate profileImage)))
      (circleLayer (car (
        gimp-image-get-layer-by-name siteProfileImage "Circle"
      )))
    )

    (gimp-image-remove-layer siteProfileImage circleLayer)
    (gimp-image-scale siteProfileImage 538 523)

    (file-webp-save
      RUN-NONINTERACTIVE       ; Interactive, non-interactive
      siteProfileImage         ; Input image
      (car (
        gimp-image-flatten siteProfileImage
      ))                       ; Drawable to save
      "dist/site-profile.webp" ; The name of the file to save the image to
      "dist/site-profile.webp" ; The name entered
      0                        ; preset
      0                        ; Use lossless encoding
      90                       ; Quality of the image
      100                      ; Quality of the image's alpha channel
      0                        ; Use layers for animation
      0                        ; Loop animation infinitely
      0                        ; Minimize animation size
      0                        ; Maximum distance between key-frames
      1                        ; Toggle saving exif data
      1                        ; Toggle saving iptc data
      0                        ; Toggle saving xmp data
      0                        ; Delay to use when timestamps are not available or forced
      0                        ; Force delay on all frames
    )

    (gimp-image-delete siteProfileImage)

  )

  (gimp-image-delete profileImage)

)

(gimp-quit 0)
