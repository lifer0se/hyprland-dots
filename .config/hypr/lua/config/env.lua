-- Env vars reach the whole desktop (Hyprland starts directly, not a systemd unit);
-- ~/.config/environment.d/desktop.conf is read only by the systemd manager — sync both.
hl.env("XCURSOR_SIZE", "30")
hl.env("HYPRCURSOR_SIZE", "30")
hl.env("XCURSOR_THEME", "Breeze_Light")
hl.env("HYPRCURSOR_THEME", "Breeze_Light")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
hl.env("QT_QPA_PLATFORMTHEME_QT5", "qt5ct")
hl.env("EDITOR", "nvim")
hl.env("VISUAL", "nvim")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")