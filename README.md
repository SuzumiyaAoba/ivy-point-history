# ivy-point-history

This package provides [point-history](https://github.com/blue0513/point-history) with [ivy](https://github.com/abo-abo/swiper) interface.

## Requirements

- [point-history](https://github.com/blue0513/point-history)
- [ivy](https://github.com/abo-abo/swiper)

## Usage

You clone this package, `point-history` and `ivy`, and edit your `init.el` as follows:

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'point-history)

(require 'ivy-point-history)
```

If you use `straight.el`, you just add follows to your `init.el`:

```elisp
(use-package point-history
  :straight (point-history :type git :host github :repo "blue0513/point-history")
  :config
  (point-history-mode t))

(use-package ivy-point-history
  :straight (ivy-point-history :type git :host github :repo "SuzumiyaAoba/ivy-point-history"))
```
