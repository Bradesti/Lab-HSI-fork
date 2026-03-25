// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "binary_search.h"

int binary_search(int *v, int len, int dest)
{
	int start = 0;
	int end = len - 1;
	int middle, ans = -1;
	goto C0;

L0:
	middle = (start + end) / 2;
	goto C1;
L1:
	start = middle + 1;
	goto C2;
L2:
	end = middle - 1;
	goto C2;
L3:
	ans = middle;
	goto END;
C0:
	if (start <= end) {
		goto L0;
	}
	goto END;
C1:
	if (v[middle] < dest) {
		goto L1;
	}
	goto L2;
C2:
	if (v[middle] == dest) {
		goto L3;
	}
	goto C0;
END:
	return ans;
}
