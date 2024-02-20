###################################### COLORS
.SILENT:

CYAN	= \033[0;36m
PURPLE	= \033[0;35m
GREEN	= \033[0;32m
RESET	= \033[0m

###################################### PROJECT FILES

NAME_CLIENT	= client
NAME_SERVER	= server

CFLAGS		= -Wextra -Wall -Werror
HEADERS		= -I ./include -I./lib/libft

LIBFT		= ./lib/libft
LIB			= $(LIBFT)/libft.a
SRC_CLIENT	= ./src/client.c
SRC_SERVER	= ./src/server.c
OBJ_CLIENT	= ${SRC_CLIENT:%.c=%.o}
OBJ_SERVER	= ${SRC_SERVER:%.c=%.o}

###################################### COMPILATION

all: libft $(NAME_CLIENT) $(NAME_SERVER)

libft:
	# $(MAKE) -c ./lib/libft
	# @echo "$(GREEN)This beautiful LIBFT is also ready!$(RESET)"
	@make -sC $(LIBFT)
# %.o: %.c
# 	$(CC) $(CFLAGS) $(HEADERS) -o $@ -c $<

$(NAME_CLIENT): $(OBJ_CLIENT)
	$(CC) $(OBJ_CLIENT) $(LIBFT) $(HEADERS) -o $(NAME_CLIENT)

$(NAME_SERVER): $(OBJ_SERVER)
	$(CC) $(OBJ_SERVER) $(LIB) $(HEADERS) -o $(NAME_SERVER)

clean:
	rm -rf $(OBJS)
	@echo "$(CYAN)Yeap! The mess was clean up!$(RESET)"

fclean: clean
	rm -rf $(NAME_CLIENT) $(NAME_SERVER)

re: fclean all

.PHONY: all, clean, fclean, re, libft, bonus
