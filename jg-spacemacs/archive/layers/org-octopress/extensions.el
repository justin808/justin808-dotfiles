;;; extensions.el --- org-octopress Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq org-octopress-pre-extensions
      '(
        ;; pre extension names go here
        ))

(setq org-octopress-post-extensions
      '(
        org-octopress/init-org-octopress
        ;; post extension names go here
        ))

;; For each extension, define a function org-octopress/init-<extension-name>
;;
(defun org-octopress/init-org-octopress ()
  "Initialize my extension"
  ;;(add-to-list 'load-path "~/forks/orglue")
  ;;(require 'org-octopress)

  ;; the converter from org to jekyll html files
  (require 'ox-jekyll)

  ;; I prefer to use the plugin for source formatting. More colors!
  (setq org-jekyll-use-src-plugin t)

  ;; We're going to create the yaml-front-matter in the rake task
  (setq org-jekyll-include-yaml-front-matter nil)

  (defun save-then-publish ()
    (interactive)
    (save-buffer)
    (org-save-all-org-buffers)
    (org-publish-project "blog" ))

  (setq org-export-with-sub-superscripts `{})

  (setq my-common-octopress-settings
        '(:base-extension "org"
                          :with-toc nil
                          :with-sub-superscript nil
                          :section-numbers nil
                          :recursive t
                          :publishing-function org-jekyll-publish-to-html
                          :headline-levels 4
                          :body-only t))

  (setq my-static-directories '("about" "meta" "tips"))
  (setq my-base-directory "~/a/railsonmaui-octopress/source")

  (defun my-create-octopress-static (prj)
    (let ((base-dir (expand-file-name prj)))
      `(,prj . (:base-directory ,base-dir
                                :publishing-directory ,base-dir
                                ,@my-common-octopress-settings))))

  (defun my-static-components ()
    (mapcar 'my-create-octopress-static my-static-directories))

  (let ((default-directory my-base-directory))
    (setq org-publish-project-alist
          `(
            ;; components
            ("blog" . (:components ("blog-org" "blog-extra" "about" "meta" "tips")))

            ;; blog articles
            ("blog-org" .  (:base-directory ,(expand-file-name "org_posts")
                                            :publishing-directory ,(expand-file-name "_posts")
                                            ,@my-common-octopress-settings))
            ("blog-extra" . (:base-directory ,(expand-file-name "org_posts")
                                             :publishing-directory ,(expand-file-name ".")
                                             :base-extension "css\\|pdf\\|png\\|jpg\\|gif\\|svg"
                                             :publishing-function org-publish-attachment
                                             :recursive t
                                             :author nil))

            ;; static articles
            ,@(my-static-components))))

  )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
