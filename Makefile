# ###################################### COLORS
# .SILENT:

# CYAN	= \033[0;36m
# PURPLE	= \033[0;35m
# GREEN	= \033[0;32m
# RESET	= \033[0m

# ###################################### PROJECT FILES

# NAME_CLIENT	= client
# NAME_SERVER	= server

# CFLAGS		= -Wextra -Wall -Werror
# HEADERS		= -I ./include -I./lib/libft

# LIBFT		= ./lib/libft
# LIB			= $(LIBFT)/libft.a
# SRC_CLIENT	= ./src/client.c
# SRC_SERVER	= ./src/server.c
# OBJ_CLIENT	= ${SRC_CLIENT:%.c=%.o}
# OBJ_SERVER	= ${SRC_SERVER:%.c=%.o}

# ###################################### COMPILATION

# all: libft $(NAME_CLIENT) $(NAME_SERVER)

# libft:
# 	# $(MAKE) -c ./lib/libft
# 	# @echo "$(GREEN)This beautiful LIBFT is also ready!$(RESET)"
# 	@make -sC $(LIBFT)
# # %.o: %.c
# # 	$(CC) $(CFLAGS) $(HEADERS) -o $@ -c $<

# $(NAME_CLIENT): $(OBJ_CLIENT)
# 	$(CC) $(OBJ_CLIENT) $(LIBFT) $(HEADERS) -o $(NAME_CLIENT)

# $(NAME_SERVER): $(OBJ_SERVER)
# 	$(CC) $(OBJ_SERVER) $(LIB) $(HEADERS) -o $(NAME_SERVER)

# clean:
# 	rm -rf $(OBJS)
# 	@echo "$(CYAN)Yeap! The mess was clean up!$(RESET)"

# fclean: clean
# 	rm -rf $(NAME_CLIENT) $(NAME_SERVER)

# re: fclean all

# .PHONY: all, clean, fclean, re, libft, bonus


# Compiler and compiling flags
CC = cc
CFLAGS = -Wall -Wextra -Werror

# Project name for the binaries
NAME_CLIENT = client
NAME_SERVER = server

# Directories
SRC_DIR = src
OBJ_DIR = obj
LIBFT_DIR = libft
INC_DIR = include

# Source files and object files
SRC_CLIENT = $(SRC_DIR)/client.c
SRC_SERVER = $(SRC_DIR)/server.c
OBJ_CLIENT = $(SRC_CLIENT:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
OBJ_SERVER = $(SRC_SERVER:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Libraries
LIBFT = $(LIBFT_DIR)/libft.a
LIBS = -L$(LIBFT_DIR) -lft

# Header files
HEADERS = -I$(INC_DIR) -I$(LIBFT_DIR)

# Rules
all: $(NAME_CLIENT) $(NAME_SERVER)

$(NAME_CLIENT): $(LIBFT) $(OBJ_CLIENT)
	$(CC) $(CFLAGS) $(OBJ_CLIENT) $(HEADERS) $(LIBS) -o $(NAME_CLIENT)

$(NAME_SERVER): $(LIBFT) $(OBJ_SERVER)
	$(CC) $(CFLAGS) $(OBJ_SERVER) $(HEADERS) $(LIBS) -o $(NAME_SERVER)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INC_DIR)/minitalk.h
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(HEADERS) -c $< -o $@

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

clean:
	$(MAKE) -C $(LIBFT_DIR) clean
	rm -rf $(OBJ_DIR)

fclean: clean
	$(MAKE) -C $(LIBFT_DIR) fclean
	rm -f $(NAME_CLIENT)
	rm -f $(NAME_SERVER)

re: fclean all

.PHONY: all clean fclean re
