# ----------------------------------------------------- COLORS

CYAN	= \033[0;36m
PURPLE	= \033[0;35m
YELLOW	= \033[33m
GREEN	= \033[0;32m
WHITE	= \033[37m
RED		= \033[31m
RESET	= \033[0m

# ------------------------------------------------------ NAME

NAME_CLIENT		= client
NAME_SERVER		= server
.DEFAULT_GOAL	:= all
.PHONY: all clean fclean re bonus
.SILENT:

# ------------------------------------------------------ PATH

SRCS_PATH	= src/
INCS_PATH	= include/ libft/
BUILD_DIR	:= build/
LIBFT_DIR	:= libft/

# ------------------------------------------------------ FILES

SRC_CLIENT	= $(addprefix $(SRCS_PATH), client.c)
SRC_SERVER	= $(addprefix $(SRCS_PATH), server.c)
LIBFT		= $(addprefix $(LIBFT_DIR), libft.a)
OBJ_CLIENT	= $(SRC_CLIENT:%.c=$(BUILD_DIR)%.o)
OBJ_SERVER	= $(SRC_SERVER:%.c=$(BUILD_DIR)%.o)
OBJS		= $(OBJ_CLIENT) $(OBJ_SERVER)
DEPS		= $(OBJS:.o=.d)

# ------------------------------------------------------ COMMANDS

MKDIR	:= mkdir -p
RM		:= rm -rf
SLEEP	= sleep 0.1
CC		= cc

# ------------------------------------------------------ FLAGS

CFLAGS		= -Wall -Wextra -Werror
DFLAGS		= -Wall -Wextra -Werror -g3 -fsanitize=address
CPPFLAGS	= $(addprefix -I ,$(INCS_PATH)) -MMD -MP
LDLIBS		= $(LIBFT_DIR)libft.a
LDFLAGS		= -ldl -lglfw -pthread

# ------------------------------------------------------ COMPILATION

COMP_OBJ		= $(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
COMP_EXE_CLIENT	= $(CC) $(LDFLAGS) $(OBJ_CLIENT) $(LDLIBS) -o $(NAME_CLIENT)
COMP_EXE_SERVER	= $(CC) $(LDFLAGS) $(OBJ_SERVER) $(LDLIBS) -o $(NAME_SERVER)

# ------------------------------------------------------ FUNCTIONS

define create_dir
	$(MKDIR) $(dir $@)
endef

define comp_objs
	$(COMP_OBJ)
endef

define comp_libft
	printf "$(RED)Building libft files\n$(RESET)"
	$(MAKE) -C $(LIBFT_DIR)
endef

define comp_exe_client
	$(COMP_EXE_CLIENT)
	# printf "\n"
	printf "$(CYAN)CLIENT-> $(RESET)$(PURPLE)Ok!\n$(RESET)"
endef

define comp_exe_server
	$(COMP_EXE_SERVER)
	# printf "\n"
	printf "$(CYAN)SERVER-> $(RESET)$(PURPLE)Ok!\n$(RESET)"
endef

# ------------------------------------------------------ TARGETS

all: $(LIBFT) $(NAME_CLIENT) $(NAME_SERVER)

$(BUILD_DIR)%.o: %.c
	$(call create_dir)
	$(call comp_objs)

$(NAME_CLIENT): $(OBJ_CLIENT)
	$(call comp_exe_client)

$(NAME_SERVER): $(OBJ_SERVER)
	$(call comp_exe_server)

$(LIBFT):
	$(call comp_libft)

clean:
	$(RM) $(BUILD_DIR)
	$(MAKE) -C $(LIBFT_DIR) clean

fclean: clean
	$(RM) $(NAME_CLIENT) $(NAME_SERVER)
	$(MAKE) -C $(LIBFT_DIR) fclean

re: fclean all

-include $(DEPS)
