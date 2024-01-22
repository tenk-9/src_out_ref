#include <stdio.h>

__global__ void HelloThread()
{
	int block_id = blockIdx.x + blockIdx.y * blockDim.x + blockIdx.z * (blockDim.x * blockDim.y);
	int thread_id = threadIdx.x + threadIdx.y * 2 + threadIdx.z * (2 * 2);
	const int thread_amount = 2 * 2 * 2;
	int global_thread_id = block_id * thread_amount + thread_id;
	printf(
		"Hello Threads!  blk %2d@(%d,%d,%d), thr%2d@(%d,%d,%d), %3d\n",
		block_id, blockIdx.x, blockIdx.y, blockIdx.z,
		thread_id, threadIdx.x, threadIdx.y, threadIdx.z,
		global_thread_id);
}

int main()
{
	dim3 a(3, 2, 6), b(2, 2, 2); // blocks: 3*2*6, threads: 2*2*2
	HelloThread<<<a, b>>>();	 // 36 blocks, 8 threads = 288 parallel
	cudaDeviceSynchronize();	 // wait CPU to finish process written above
	return 0;
}
