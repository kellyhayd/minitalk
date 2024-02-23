/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: krocha-h <krocha-h@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 16:55:55 by krocha-h          #+#    #+#             */
/*   Updated: 2024/02/23 13:53:17 by krocha-h         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	handler(int sig)
{
	static char	c;
	static int	bits;

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

int main(void)
{
	// struct
	ft_printf("PID: %d\n", getpid());
	signal(SIGUSR1, handler);
	signal(SIGUSR2, handler);
	while (1)
		pause();
	return (0);
}
