/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: krocha-h <krocha-h@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 16:55:53 by krocha-h          #+#    #+#             */
/*   Updated: 2024/02/22 15:12:58 by krocha-h         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"
#include <signal.h>

void	send_byte(pid_t pid, char c)
{
	int	i;
	int	signal;

	i = 7;
	while (i >= 0)
	{
		if (((c >> i) & 1) == 1)
			signal = SIGUSR1;
		else
			signal = SIGUSR2;
		if (kill(pid, signal) == -1)
		{
			ft_putstr_fd("Error\n", 2);
			exit(EXIT_FAILURE);
		}
		usleep(42);
		i--;
	}
}

void	send_message(pid_t pid, char *str)
{
	char	c;
	int		i;

	while (str[i] != '\0')
	{
		c = str[i];
		send_byte(pid, c);
		i++;
	}
	if (str[i] == '\0')
		send_byte(pid, '\0');
}

int	main(int argc, char **argv)
{
	pid_t	pid;

	if (argc != 3)
	{
		ft_putstr_fd("Wrong number of arguments!\n", 2);
		ft_putstr_fd("Format: ./client <PID> <MESSAGE>", 2);
		exit(EXIT_FAILURE);
	}
	pid = ft_atoi(argv[1]);
	if (pid <= 0)
	{
		ft_putstr_fd("Error\n", 2);
		exit(EXIT_FAILURE);
	}
	send_message(pid, argv[2]);
	return (0);
}
