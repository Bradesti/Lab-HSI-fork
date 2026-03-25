// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "vector_max.h"

int vector_max(int *v, int len)
{
	int max = v[0];
	unsigned int i = 0;

	goto C0;
L0:
	goto C1;
L1:
	max = v[i];
	goto C0;
C1:
	if (v[i] > max) {
		goto L1;
	}
	i++;
C0:
	if (i < len) {
		goto L0;
	}

	return max;
}
