/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: krocha-h <krocha-h@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 16:55:55 by krocha-h          #+#    #+#             */
/*   Updated: 2024/02/23 14:56:16 by krocha-h         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	handler(int sig, siginfo_t *info, void *context)
{
	static char	c;
	static int	bits;

	(void)context;
	(void)info;
	c = c | (sig == SIGUSR1);
	bits++;
	if (bits == 8)
	{
		write(1, &c, 1);
		if (c == '\0')
			write(1, "\n", 1);
		bits = 0;
		c = 0;
	}
	else
		c = c << 1;
}

int	main(void)
{
	struct sigaction	s_sign;

	sigemptyset(&s_sign.sa_mask);
	s_sign.sa_handler = NULL;
	s_sign.sa_flags = SA_RESTART | SA_SIGINFO;
	s_sign.sa_sigaction = handler;
	sigaction(SIGUSR1, &s_sign, NULL);
	sigaction(SIGUSR2, &s_sign, NULL);
	ft_printf("PID: %d\n", getpid());
	while (1)
		pause();
	return (0);
}
