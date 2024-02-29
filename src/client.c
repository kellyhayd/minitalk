/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: krocha-h <krocha-h@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 16:55:53 by krocha-h          #+#    #+#             */
/*   Updated: 2024/02/29 15:51:56 by krocha-h         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"
#include <signal.h>

int	g_confirm_flag = 0;

void	handler_back(int sig, siginfo_t *info, void *context)
{
	(void)sig;
	(void)context;
	(void)info;
	g_confirm_flag = 1;
}

void	send_byte(pid_t pid, unsigned char c)
{
	int	i;
	int	signal;

	i = 7;
	while (i >= 0)
	{
		if (((c >> i) & 1) == 1)
			signal = SIGUSR2;
		else
			signal = SIGUSR1;
		if (kill(pid, signal) == -1)
		{
			ft_putstr_fd("Error\n", 2);
			exit(EXIT_FAILURE);
		}
		while (!g_confirm_flag)
			;
		g_confirm_flag = 0;
		i--;
	}
}

void	send_message(pid_t pid, char *str)
{
	int		i;

	i = 0;
	while (str[i] != '\0')
	{
		send_byte(pid, (unsigned char)str[i]);
		i++;
	}
	if (str[i] == '\0')
		send_byte(pid, '\0');
}

int	main(int argc, char **argv)
{
	pid_t				pid;
	struct sigaction	s_sign;

	if (argc != 3)
	{
		ft_putstr_fd("Wrong number of arguments!\n", 2);
		ft_putstr_fd("Format: ./client <PID> <MESSAGE>\n", 2);
		exit(EXIT_FAILURE);
	}
	pid = ft_atoi(argv[1]);
	if (pid <= 0)
	{
		ft_putstr_fd("Error\n", 2);
		exit(EXIT_FAILURE);
	}
	sigemptyset(&s_sign.sa_mask);
	s_sign.sa_handler = NULL;
	s_sign.sa_sigaction = &handler_back;
	s_sign.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &s_sign, NULL);
	sigaction(SIGUSR2, &s_sign, NULL);
	send_message(pid, argv[2]);
	return (0);
}
