import sys
import pygame

MENU_OPTIONS = ["Start Game", "Settings", "Exit Game"]


def render_centered(surface, font, message, width, height):
    text = font.render(message, True, (255, 255, 255))
    rect = text.get_rect(center=(width // 2, height // 2))
    surface.blit(text, rect)


def main():
    pygame.init()
    info = pygame.display.Info()
    screen = pygame.display.set_mode((info.current_w, info.current_h), pygame.FULLSCREEN)
    pygame.display.set_caption("Unnamed Horror Game")

    font = pygame.font.Font(None, 64)
    selected = 0
    running = True
    in_settings = False
    in_game = False

    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if in_game or in_settings:
                    if event.key in (pygame.K_ESCAPE, pygame.K_RETURN):
                        in_game = False
                        in_settings = False
                else:
                    if event.key == pygame.K_UP:
                        selected = (selected - 1) % len(MENU_OPTIONS)
                    elif event.key == pygame.K_DOWN:
                        selected = (selected + 1) % len(MENU_OPTIONS)
                    elif event.key == pygame.K_RETURN:
                        choice = MENU_OPTIONS[selected]
                        if choice == "Start Game":
                            in_game = True
                        elif choice == "Settings":
                            in_settings = True
                        elif choice == "Exit Game":
                            running = False

        screen.fill((0, 0, 0))
        if in_game:
            render_centered(screen, font, "Game starting...", info.current_w, info.current_h)
        elif in_settings:
            render_centered(screen, font, "Settings - Press ESC to return", info.current_w, info.current_h)
        else:
            for index, option in enumerate(MENU_OPTIONS):
                color = (255, 255, 255) if index == selected else (150, 150, 150)
                text = font.render(option, True, color)
                rect = text.get_rect(center=(info.current_w // 2, info.current_h // 2 + index * 80))
                screen.blit(text, rect)

        pygame.display.flip()

    pygame.quit()
    sys.exit()


if __name__ == "__main__":
    main()
