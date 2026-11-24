
avx2_gathers_and_masked_transfers_follow_the_sdm.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<_mm_i32gather_epi32>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movl	0x58(%rsp), %r8d
               	movl	%r8d, 0x30(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x10(%rsp,%rax,4), %r8d
               	movl	%r8d, 0x58(%rsp)
               	movl	0x20(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x40(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x20(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x8(%rbp), %r8d
               	movl	%r8d, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_epi64>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x58(%rsp), %r8
               	movq	%r8, 0x30(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x10(%rsp,%rax,8), %r8
               	movq	%r8, 0x58(%rsp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x40(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x40(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rsi)
               	movups	%xmm0, 0x60(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r8
               	movq	%r8, 0x40(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	0x60(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i64gather_epi32>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movl	0x58(%rsp), %r9d
               	movl	%r9d, 0x30(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0x10(%rsp,%rax,4), %r8d
               	movl	%r8d, 0x58(%rsp)
               	movl	0x20(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	leaq	0x40(%rsp), %r8
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%r8)
               	vmovups	%ymm0, (%rsp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %r9d
               	movl	%r9d, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq

<_mm_i64gather_epi64>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x58(%rsp), %r9
               	movq	%r9, 0x30(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x10(%rsp,%rax,8), %r8
               	movq	%r8, 0x58(%rsp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	leaq	(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x40(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	(%rsp), %rdx
               	vmovups	(%r8), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%r9, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x60(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_ps>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movl	0x58(%rsp), %r8d
               	movl	%r8d, 0x30(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x10(%rsp,%rax,4), %r8d
               	movl	%r8d, 0x58(%rsp)
               	movl	0x20(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x40(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x20(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x8(%rbp), %r8d
               	movl	%r8d, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_pd>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x58(%rsp), %r8
               	movq	%r8, 0x30(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x10(%rsp,%rax,8), %r8
               	movq	%r8, 0x58(%rsp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movslq	0x40(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x40(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x40(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rsi)
               	movups	%xmm0, 0x60(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r8
               	movq	%r8, 0x40(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	0x60(%rsp,%rax,4), %rbx
               	shlq	$0x3, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_mask_i64gather_ps>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	movups	%xmm0, 0x10(%rsp)
               	movups	%xmm2, 0x20(%rsp)
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm1, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	0x58(%rsp), %r9d
               	movl	%r9d, 0x30(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0x10(%rsp,%rax,4), %r8d
               	movl	%r8d, 0x58(%rsp)
               	movl	0x20(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm_i64gather_ps>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movl	0x58(%rsp), %r9d
               	movl	%r9d, 0x30(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0x10(%rsp,%rax,4), %r8d
               	movl	%r8d, 0x58(%rsp)
               	movl	0x20(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_mask_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm2, 0x30(%rsp)
               	leaq	0x40(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	vmovups	%ymm1, (%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x8(%rbp), %r9d
               	movl	%r9d, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq

<_mm256_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	leaq	0x40(%rsp), %r8
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%r8)
               	vmovups	%ymm0, (%rsp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %r9d
               	movl	%r9d, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq

<_mm_mask_i64gather_pd>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	movups	%xmm0, 0x10(%rsp)
               	movups	%xmm2, 0x20(%rsp)
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm1, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	0x58(%rsp), %r9
               	movq	%r9, 0x30(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x10(%rsp,%rax,8), %r8
               	movq	%r8, 0x58(%rsp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm_i64gather_pd>:
               	subq	$0x60, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	leaq	0x30(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
               	movups	%xmm0, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x58(%rsp), %r9
               	movq	%r9, 0x30(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x10(%rsp,%rax,8), %r8
               	movq	%r8, 0x58(%rsp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	0x58(%rsp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm0
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq

<_mm256_mask_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm2, 0x20(%rsp)
               	leaq	0x40(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0x60(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%r9, 0x40(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	0x60(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	leaq	(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x40(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	(%rsp), %rdx
               	vmovups	(%r8), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x20(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%r9, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x60(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<prepare>:
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r9, 0x38(%rsp)
               	movslq	%r8d, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rcx, %r13
               	movslq	%edx, %rbx
               	movq	%rsi, 0x40(%rsp)
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	0x40(%r12), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%ebp, %ebp
               	leaq	0x20(%r12), %r14
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	0x60(%r12), %r15
               	cmpl	0x40(%rsp), %ebp
               	jge	<addr>
               	movl	$0x1, %r9d
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3e, %rax
               	testl	%eax, %eax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x1f8, %eax            # imm = 0x1F8
               	cltd
               	idivl	0x48(%rsp)
               	movslq	%eax, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rsi
               	movq	%rcx, %rdi
               	shlq	%rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	subq	%rcx, %rdx
               	movq	%r13, %rcx
               	imulq	%rbp, %rcx
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r12,%rdi)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x30(%rsp), %r10
               	shlxq	%r10, %rax, %rcx
               	movq	%rbx, %rdi
               	imulq	%rbp, %rdi
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	leaq	(%rdi,%rax), %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%r14,%rsi)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rdx, %rax
               	imulq	0x48(%rsp), %rax
               	movq	$0x0, 0x58(%rsp)
               	leaq	0x58(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	0x58(%rsp), %rdx
               	movq	%rbx, %rcx
               	imulq	%rbp, %rcx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r15,%rdi)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	jmp	<addr>
               	leaq	0x40(%r12), %rax
               	movq	$0x0, 0x58(%rsp)
               	leaq	0x58(%rsp), %rdi
               	movq	%rbx, %rcx
               	imulq	%rbp, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	0x58(%rsp), %rdx
               	jmp	<addr>
               	movl	$0x7f, %ecx
               	jmp	<addr>
               	movl	$0x10000000, %edx       # imm = 0x10000000
               	jmp	<addr>
               	incq	%rbp
               	cmpl	0x40(%rsp), %ebp
               	jl	<addr>
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x38, %rsp
               	retq

<check_gathers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x160, %rsp            # imm = 0x160
               	andq	$-0x20, %rsp
               	movq	%rdi, %r12
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	xorl	%ebx, %ebx
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x140(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x150(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x60(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x1, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x1, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x1, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	%ymm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x1, %esi
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rsi, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x140(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rsi, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x150(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x60(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rsi, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rsi, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x2, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x2, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x2, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	%ymm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x2, %esi
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x140(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x150(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x60(%rsp), %r8
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rdx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x4, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x4, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %r8d
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x4, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	%ymm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x4, %esi
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rdx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %r8d
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rsi, %rcx
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rdx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x1, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rcx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rcx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x100(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%r12, %r9
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x8, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%r12, %r9
               	movq	%rcx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x8, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	%xmm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	movups	%xmm0, 0xa0(%rsp)
               	movl	$0x8, %esi
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%r12, %r9
               	movq	%rdx, %r8
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %r9
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	%ymm1, 0xc0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rdi
               	leaq	0xa0(%rsp), %rcx
               	vmovups	%ymm0, 0xa0(%rsp)
               	movl	$0x8, %esi
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	testl	%r12d, %r12d
               	cmoveq	%rcx, %rax
               	orq	%rax, %rbx
               	movq	%rbx, %rax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0x80(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x120(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0x80(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	0xa0(%rsp,%rax,8), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %esi
               	movl	%esi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	%edx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>

<check_masked_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x480, %rsp            # imm = 0x480
               	andq	$-0x20, %rsp
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xa0(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x80(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x60(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r15d, %r15d
               	movl	$0x4, %ebx
               	movl	$0x10, %r14d
               	xorl	%r13d, %r13d
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jge	<addr>
               	movq	%rbx, %rax
               	imulq	%r13, %rax
               	leaq	(%rax,%rbx), %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	movzbq	-0x60(%rbp,%rdx), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	movq	$0x0, -0xa8(%rbp)
               	leaq	-0xa8(%rbp), %rdi
               	movslq	%eax, %rax
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	movq	-0xa8(%rbp), %rdx
               	movq	%rbx, %rsi
               	imulq	%r13, %rsi
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movslq	%edi, %rdi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x40(%rbp,%rdi)
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%r13
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jl	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movups	-0x60(%rbp), %xmm14
               	movups	%xmm14, -0x100(%rbp)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	-0x80(%rbp), %xmm14
               	movups	%xmm14, -0x110(%rbp)
               	vmovups	-0x80(%rbp), %ymm14
               	vmovups	%ymm14, -0x130(%rbp)
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x370(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0xe8(%rbp), %edx
               	movl	%edx, 0x380(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x0, -0xe8(%rbp)
               	movl	0x370(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0xe8(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rsi, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	jmp	<addr>
               	movups	0x380(%rsp), %xmm0
               	movups	%xmm0, 0x360(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x390(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	-0xe0(%rbp), %esi
               	movl	%esi, 0x3a0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	%ecx, -0xe0(%rbp)
               	movl	0x390(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	movups	0x3a0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x360(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	xorl	%r13d, %r13d
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jge	<addr>
               	movq	%rbx, %rcx
               	imulq	%r13, %rcx
               	leaq	(%rcx,%rbx), %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	movzbq	-0x60(%rbp,%rdx), %rax
               	testb	$-0x80, %al
               	je	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	$0x0, -0xa8(%rbp)
               	leaq	-0xa8(%rbp), %rdi
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	movq	-0xa8(%rbp), %rdx
               	movq	%rbx, %rsi
               	imulq	%r13, %rsi
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movslq	%edi, %rdi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, -0x40(%rbp,%rdi)
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rax
               	jmp	<addr>
               	incq	%r13
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r13d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	orq	%rcx, %r15
               	incq	%r12
               	cmpl	$0x2, %r12d
               	jge	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x3f0(%rsp)
               	movups	-0x110(%rbp), %xmm14
               	movups	%xmm14, 0x400(%rsp)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	movl	0x3f0(%rsp,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	movl	0x400(%rsp,%rcx,4), %esi
               	movl	%esi, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%r14, %rdx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax,%r14), %rdi
               	leaq	-0xa0(%rbp), %rax
               	leaq	(%rax,%r14), %rsi
               	movl	$0x20, %edx
               	subq	%r14, %rdx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x410(%rsp)
               	movups	-0x110(%rbp), %xmm14
               	movups	%xmm14, 0x420(%rsp)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	movl	0x410(%rsp,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	movl	0x420(%rsp,%rcx,4), %esi
               	movl	%esi, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x1e0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x200(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x220(%rsp)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movl	0x200(%rsp,%rcx,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	movl	0x220(%rsp,%rcx,4), %edx
               	movl	%edx, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x240(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x260(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x280(%rsp)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movl	0x260(%rsp,%rcx,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	movl	0x280(%rsp,%rcx,4), %edx
               	movl	%edx, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x430(%rsp)
               	movups	-0x110(%rbp), %xmm14
               	movups	%xmm14, 0x440(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x430(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	0x440(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x20(%rbp,%rax,8)
               	jmp	<addr>
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x450(%rsp)
               	movups	-0x110(%rbp), %xmm14
               	movups	%xmm14, 0x460(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0x450(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	0x460(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x20(%rbp,%rax,8)
               	jmp	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	(%rsp), %rcx
               	leaq	0x2a0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x2c0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x2e0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x2c0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	0x2e0(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x20(%rbp,%rax,8)
               	jmp	<addr>
               	leaq	(%rsp), %rcx
               	leaq	0x300(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x320(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x340(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x320(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	0x340(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x20(%rbp,%rax,8)
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0xd8(%rbp), %edx
               	movl	%edx, 0xa0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	$0x0, -0xd8(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rsi, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	-0xd0(%rbp), %esi
               	movl	%esi, 0x100(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	%ecx, -0xd0(%rbp)
               	movl	0xe0(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	jmp	<addr>
               	vmovups	0x100(%rsp), %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x3b0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rdx
               	movq	%rdx, 0x3c0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	$0x0, -0xc8(%rbp)
               	movq	0x3b0(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	jmp	<addr>
               	movups	0x3c0(%rsp), %xmm0
               	movups	%xmm0, 0x360(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x3d0(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rsi
               	movq	%rsi, 0x3e0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rcx, -0xc0(%rbp)
               	movq	0x3d0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	movups	0x3e0(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x360(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x120(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x140(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rdx
               	movq	%rdx, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	$0x0, -0xb8(%rbp)
               	movq	0x140(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rsi, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	jmp	<addr>
               	vmovups	0x160(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	(%rsp), %rcx
               	leaq	0x180(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x1a0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rsi
               	movq	%rsi, 0x1c0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rcx, -0xb0(%rbp)
               	movq	0x1a0(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	jmp	<addr>
               	vmovups	0x1c0(%rsp), %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	addq	$0x10, %r14
               	cmpl	$0x20, %r14d
               	jle	<addr>
               	addq	$0x4, %rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	movl	$0x8, %eax
               	xorl	%ecx, %ecx
               	testq	%r15, %r15
               	cmoveq	%rcx, %rax
               	leaq	-0x160(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_lane_access>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x60(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x58(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x56(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x54(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x52(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x50(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x48(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x46(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x44(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x42(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movswq	-0x60(%rbp), %rax
               	movw	%ax, (%rsp)
               	movswq	-0x5e(%rbp), %rax
               	movw	%ax, 0x2(%rsp)
               	movswq	-0x5c(%rbp), %rax
               	movw	%ax, 0x4(%rsp)
               	movswq	-0x5a(%rbp), %rax
               	movw	%ax, 0x6(%rsp)
               	movswq	-0x58(%rbp), %rax
               	movw	%ax, 0x8(%rsp)
               	movswq	-0x56(%rbp), %rax
               	movw	%ax, 0xa(%rsp)
               	movswq	-0x54(%rbp), %rax
               	movw	%ax, 0xc(%rsp)
               	movswq	-0x52(%rbp), %rax
               	movw	%ax, 0xe(%rsp)
               	movswq	-0x50(%rbp), %rax
               	movw	%ax, 0x10(%rsp)
               	movswq	-0x4e(%rbp), %rax
               	movw	%ax, 0x12(%rsp)
               	movswq	-0x4c(%rbp), %rax
               	movw	%ax, 0x14(%rsp)
               	movswq	-0x4a(%rbp), %rax
               	movw	%ax, 0x16(%rsp)
               	movswq	-0x48(%rbp), %rax
               	movw	%ax, 0x18(%rsp)
               	movswq	-0x46(%rbp), %rax
               	movw	%ax, 0x1a(%rsp)
               	movswq	-0x44(%rbp), %rax
               	movw	%ax, 0x1c(%rsp)
               	movswq	-0x42(%rbp), %rax
               	movw	%ax, 0x1e(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movswq	-0x60(%rbp), %rax
               	movw	%ax, (%rsp)
               	movswq	-0x5e(%rbp), %rax
               	movw	%ax, 0x2(%rsp)
               	movswq	-0x5c(%rbp), %rax
               	movw	%ax, 0x4(%rsp)
               	movswq	-0x5a(%rbp), %rax
               	movw	%ax, 0x6(%rsp)
               	movswq	-0x58(%rbp), %rax
               	movw	%ax, 0x8(%rsp)
               	movswq	-0x56(%rbp), %rax
               	movw	%ax, 0xa(%rsp)
               	movswq	-0x54(%rbp), %rax
               	movw	%ax, 0xc(%rsp)
               	movswq	-0x52(%rbp), %rax
               	movw	%ax, 0xe(%rsp)
               	movswq	-0x50(%rbp), %rax
               	movw	%ax, 0x10(%rsp)
               	movswq	-0x4e(%rbp), %rax
               	movw	%ax, 0x12(%rsp)
               	movswq	-0x4c(%rbp), %rax
               	movw	%ax, 0x14(%rsp)
               	movswq	-0x4a(%rbp), %rax
               	movw	%ax, 0x16(%rsp)
               	movswq	-0x48(%rbp), %rax
               	movw	%ax, 0x18(%rsp)
               	movswq	-0x46(%rbp), %rax
               	movw	%ax, 0x1a(%rsp)
               	movswq	-0x44(%rbp), %rax
               	movw	%ax, 0x1c(%rsp)
               	movswq	-0x42(%rbp), %rax
               	movw	%ax, 0x1e(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	-0x40(%rbp), %rax
               	movq	%rax, (%rsp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, 0x8(%rsp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	-0x28(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movq	%rax, 0x18(%rsp)
               	leaq	0x60(%rsp), %rdi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x40(%rbp), %rsi
               	movups	-0x40(%rbp), %xmm0
               	movups	-0x30(%rbp), %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm0, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovq	%xmm1, %rax
               	vmovq	%rax, %xmm2
               	vpextrq	$0x1, %xmm1, %rax
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x80(%rsp), %rdi
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movzwq	0x20(%rsp), %rax
               	movswq	-0x60(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movzwq	0x32(%rsp), %rcx
               	movswq	-0x4e(%rbp), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzwq	0x3e(%rsp), %rax
               	movswq	-0x42(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x60(%rbp), %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movq	-0x40(%rbp), %rax
               	movw	%ax, -0x6(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movswq	%ax, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	(%rsp), %rdi
               	vmovups	%ymm0, (%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	0x60(%rsp), %ecx
               	movl	-0x40(%rbp), %edx
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rax
               	movl	$0x10, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<check_transfers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xa0(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdx
               	leaq	-0xa0(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	movups	-0x1d(%rbp), %xmm0
               	movups	-0x9f(%rbp), %xmm1
               	vmovq	%xmm0, %rdx
               	vmovq	%rdx, %xmm2
               	vpextrq	$0x1, %xmm0, %rdx
               	movapd	%xmm2, %xmm0
               	vpinsrq	$0x1, %rdx, %xmm0, %xmm0
               	vmovq	%xmm1, %rdx
               	vmovq	%rdx, %xmm2
               	vpextrq	$0x1, %xmm1, %rdx
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %rdx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	(%rsp), %rdi
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x60(%rbp), %rsi
               	addq	$0x3, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rcx
               	incq	%rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movups	-0x20(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	vmovdqa	%xmm0, %xmm2
               	vinserti128	$0x1, %xmm1, %ymm2, %ymm2
               	leaq	0x20(%rsp), %rdi
               	vmovups	%ymm2, 0x20(%rsp)
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	vzeroupper
               	callq	<addr>
               	movsd	(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x10(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	movups	%xmm0, -0x3b(%rbp)
               	vmovq	%xmm2, %xmm0            # xmm0 = xmm2[0],zero
               	vunpcklpd	%xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm3[0]
               	movups	%xmm0, -0x1f(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x5(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x21(%rax), %rdi
               	leaq	-0x60(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rax # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rax)
               	movl	$0x20, %edx
               	leaq	0x20(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	vmovups	0x20(%rax), %ymm0
               	leaq	0x60(%rsp), %rdi
               	vmovups	%ymm0, 0x60(%rsp)
               	vmovups	-0x80(%rbp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xc0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xc0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rbx, %rcx
               	movl	$0x20, %eax
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq

<check_tests>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rdx, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	imulq	%rdi, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x20(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	imulq	%rdi, %rdx
               	shrq	$0x3e, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	-0x20(%rbp,%rax), %rdx
               	movzbq	-0x40(%rbp,%rax), %r8
               	xorq	$-0x1, %r8
               	andq	$0xff, %r8
               	andq	%r8, %rdx
               	movb	%dl, -0x20(%rbp,%rax)
               	jmp	<addr>
               	xorl	%r10d, %r10d
               	movq	%r10, -0xd0(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0xd0(%rbp), %r14
               	movq	-0xd0(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	movq	-0x50(%rbp,%rdx,8), %r12
               	sarq	%rax
               	movq	-0x50(%rbp,%rax,8), %r9
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movq	%rcx, %rdx
               	movzbq	(%r12,%rax), %rsi
               	movzbq	(%r9,%rax), %rdi
               	movq	%rsi, %r8
               	andq	%rdi, %r8
               	testl	%r8d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmovups	(%r12), %ymm1
               	vmovups	(%r9), %ymm2
               	vpand	%ymm2, %ymm1, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%edx, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm1, %ymm0
               	vpand	%ymm2, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	vpand	%ymm2, %ymm1, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rax, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm1, %ymm0
               	vpand	%ymm2, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%edx, %edx
               	cmovneq	%rsi, %rcx
               	cmpl	%ecx, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	orq	%rsi, %r14
               	movl	$0x4, %ebx
               	movl	$0x10, %r8d
               	jmp	<addr>
               	orq	%rsi, %r14
               	addq	$0x10, %r8
               	cmpl	$0x20, %r8d
               	jg	<addr>
               	movl	$0x1, %ecx
               	leaq	-0x1(%rbx), %rax
               	movq	%rcx, %rdx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movzbq	(%r12,%rax), %rsi
               	movzbq	(%r9,%rax), %rdi
               	movq	%rsi, %r13
               	andq	%rdi, %r13
               	andq	$0x80, %r13
               	testl	%r13d, %r13d
               	sete	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	andq	$0x80, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	addq	%rbx, %rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r8d
               	jne	<addr>
               	movups	(%r12), %xmm0
               	movups	(%r9), %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %esi
               	movslq	%esi, %rsi
               	vpextrd	$0x1, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	vpextrd	$0x2, %xmm0, %esi
               	movslq	%esi, %rsi
               	vpextrd	$0x2, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	vpextrd	$0x3, %xmm0, %esi
               	movslq	%esi, %rsi
               	vpextrd	$0x3, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %esi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	vpextrd	$0x1, %xmm1, %r13d
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	vpextrd	$0x2, %xmm0, %esi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	vpextrd	$0x2, %xmm1, %r13d
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	vpextrd	$0x3, %xmm0, %esi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	vpextrd	$0x3, %xmm1, %r13d
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm1, %r13d
               	movslq	%r13d, %r13
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %r13d
               	movslq	%r13d, %r13
               	vpextrd	$0x1, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	vpextrd	$0x2, %xmm0, %r13d
               	movslq	%r13d, %r13
               	vpextrd	$0x2, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	vpextrd	$0x3, %xmm0, %r13d
               	movslq	%r13d, %r13
               	vpextrd	$0x3, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%rax, %r13
               	xorl	%eax, %eax
               	testl	%r13d, %r13d
               	jne	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	vmovd	%xmm1, %r13d
               	movslq	%r13d, %r13
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %r13d
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	vpextrd	$0x1, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	vpextrd	$0x2, %xmm0, %r13d
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	vpextrd	$0x2, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	vpextrd	$0x3, %xmm0, %r13d
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	vpextrd	$0x3, %xmm1, %r15d
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r13d
               	cmpl	%ecx, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpl	%edx, %edi
               	cmoveq	%rsi, %r13
               	movl	$0x1, %esi
               	testq	%r13, %r13
               	jne	<addr>
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%edx, %edx
               	cmovneq	%rsi, %rcx
               	cmpl	%ecx, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	leaq	(%rsp), %rax
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %esi
               	movl	0x8(%rsp), %edi
               	movl	0xc(%rsp), %r13d
               	movl	0x10(%rsp), %r15d
               	movl	0x14(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x18(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x1c(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	(%r9), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x4(%r9), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x8(%r9), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0xc(%r9), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x10(%r9), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x14(%r9), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x18(%r9), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x1c(%r9), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movslq	%eax, %rax
               	movq	-0x70(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	andq	-0x70(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	andq	-0x70(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%edi, %rsi
               	movq	-0x80(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	movq	-0x88(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r15d, %rsi
               	movq	-0x90(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x58(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0x98(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x60(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0xa0(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x68(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0xa8(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %esi
               	movl	0x8(%rsp), %r13d
               	movl	0xc(%rsp), %r15d
               	movl	0x10(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x14(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x18(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x1c(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x20(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x24(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0xb0(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	andq	-0x78(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	andq	-0x78(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x88(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r15d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x90(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x58(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x98(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x60(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xa0(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x68(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xa8(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x70(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xb0(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x8(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0xc(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x10(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x14(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x18(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	0x1c(%rsp), %r10d
               	movq	%r10, -0xb8(%rbp)
               	movl	0x20(%rsp), %r15d
               	movl	0x24(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0xb0(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0xc0(%rbp)
               	movslq	%eax, %r13
               	movslq	%r15d, %r15
               	movq	%r13, %rax
               	andq	%r15, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x58(%rbp), %r10
               	andq	-0x60(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0x68(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	movq	-0x68(%rbp), %r10
               	andq	-0x70(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	movq	-0x78(%rbp), %r10
               	andq	-0x80(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0x88(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x90(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x90(%rbp)
               	movq	-0x88(%rbp), %r10
               	andq	-0x90(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0x98(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x98(%rbp)
               	movq	-0xa0(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xa0(%rbp)
               	movq	-0x98(%rbp), %r10
               	andq	-0xa0(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0xa8(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	-0xb0(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xb0(%rbp)
               	movq	-0xa8(%rbp), %r10
               	andq	-0xb0(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	andq	-0xc8(%rbp), %rax
               	movq	-0xb8(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xb8(%rbp)
               	movq	-0xc0(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xc0(%rbp)
               	movq	-0xb8(%rbp), %r10
               	andq	-0xc0(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0xc8(%rbp)
               	movq	%rax, %r10
               	andq	-0xc8(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	xorl	%eax, %eax
               	movq	-0xc8(%rbp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorq	$-0x1, %r13
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x60(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x68(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x70(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x78(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x88(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x90(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x98(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0xa0(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0xa8(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0xb0(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0xb8(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0xc0(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	cmpl	$0x10, %r8d
               	jne	<addr>
               	movups	(%r12), %xmm0
               	movups	(%r9), %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rsi
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%dil
               	movzbq	%dil, %rdi
               	vpextrq	$0x1, %xmm0, %rax
               	vpextrq	$0x1, %xmm1, %rsi
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rdi
               	vmovq	%xmm0, %rax
               	xorq	$-0x1, %rax
               	vmovq	%xmm1, %rsi
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%sil
               	movzbq	%sil, %rsi
               	vpextrq	$0x1, %xmm0, %rax
               	xorq	$-0x1, %rax
               	vpextrq	$0x1, %xmm1, %r13
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rsi
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %r13
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm0, %r13
               	vpextrq	$0x1, %xmm1, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%rax, %r13
               	xorl	%eax, %eax
               	testl	%r13d, %r13d
               	jne	<addr>
               	vmovq	%xmm0, %rax
               	xorq	$-0x1, %rax
               	vmovq	%xmm1, %r13
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm0, %r13
               	xorq	$-0x1, %r13
               	vpextrq	$0x1, %xmm1, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	leaq	0x40(%rsp), %rax
               	vmovups	(%r12), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x60(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rsi
               	movq	0x50(%rsp), %rdi
               	movq	0x58(%rsp), %r13
               	movq	(%r9), %r15
               	movq	0x8(%r9), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x10(%r9), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x18(%r9), %r10
               	movq	%r10, -0x68(%rbp)
               	andq	%r15, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	-0x58(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	andq	-0x60(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rsi
               	movq	0x50(%rsp), %r13
               	movq	0x58(%rsp), %r15
               	movq	0x60(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	xorq	$-0x1, %rax
               	andq	-0x58(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rsi
               	andq	-0x60(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	xorq	$-0x1, %r13
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	xorq	$-0x1, %r15
               	andq	-0x70(%rbp), %r15
               	testq	%r15, %r15
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movq	0x40(%rsp), %r13
               	movq	0x48(%rsp), %r15
               	movq	0x50(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	%r13, %rax
               	andq	-0x68(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%r15, %r10
               	andq	-0x70(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x58(%rbp), %r10
               	andq	-0x78(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x60(%rbp), %r10
               	andq	-0x80(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	%rax, %r10
               	andq	-0x88(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%eax, %eax
               	movq	-0x88(%rbp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorq	$-0x1, %r13
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %r15
               	andq	-0x70(%rbp), %r15
               	testq	%r15, %r15
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x58(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x78(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x60(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	addq	$0x4, %rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	addq	$0x1, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x40, %eax
               	xorl	%ecx, %ecx
               	testq	%r14, %r14
               	cmoveq	%rcx, %rax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<check_permutes_and_halves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x238, %rsp            # imm = 0x238
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x68(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rbx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rbx
               	vmovd	%ebx, %xmm0
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x64(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r12 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r12
               	vpinsrd	$0x1, %r12d, %xmm0, %xmm0
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x60(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r13 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r13
               	movapd	%xmm0, %xmm1
               	vpinsrd	$0x2, %r13d, %xmm1, %xmm1
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x5c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %r14 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r14
               	vpinsrd	$0x3, %r14d, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm4
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x58(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %r15 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r15
               	vmovd	%r15d, %xmm2
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x54(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movl	%ecx, -0x50(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movapd	%xmm2, %xmm3
               	vpinsrd	$0x2, %ecx, %xmm3, %xmm3
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rdx
               	movl	%edx, -0x4c(%rbp)
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r8 # imm = 0x2545F4914F6CDD1D
               	imulq	%rdx, %r8
               	vpinsrd	$0x3, %r8d, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm4, %ymm4
               	vmovups	-0x68(%rbp), %ymm5
               	movq	%rbx, %rsi
               	andq	$0x3, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x188(%rbp)
               	movq	%r12, %rsi
               	andq	$0x3, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x184(%rbp)
               	movq	%r13, %rsi
               	andq	$0x3, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x180(%rbp)
               	movq	%r14, %rsi
               	andq	$0x3, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x17c(%rbp)
               	movq	%r15, %rsi
               	andq	$0x3, %rsi
               	orq	$0x4, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x178(%rbp)
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	orq	$0x4, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x174(%rbp)
               	movq	%rcx, %rsi
               	andq	$0x3, %rsi
               	orq	$0x4, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x170(%rbp)
               	movq	%r8, %rsi
               	andq	$0x3, %rsi
               	orq	$0x4, %rsi
               	movl	-0x68(%rbp,%rsi,4), %edx
               	movl	%edx, -0x16c(%rbp)
               	vpermilps	%ymm4, %ymm5, %ymm6
               	vmovups	%ymm6, (%rsp)
               	leaq	-0x168(%rbp), %rdx
               	vmovups	%ymm6, (%rdx)
               	leaq	-0x168(%rbp), %rdi
               	leaq	-0x188(%rbp), %rsi
               	movl	$0x20, %edx
               	movups	%xmm0, -0x1e0(%rbp)
               	movups	%xmm1, -0x1f0(%rbp)
               	movq	%rax, -0x1f8(%rbp)
               	movups	%xmm2, -0x208(%rbp)
               	movq	%rcx, -0x210(%rbp)
               	movq	%r8, -0x218(%rbp)
               	movups	%xmm3, -0x228(%rbp)
               	vmovaps	%ymm4, %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovaps	%ymm5, %ymm14
               	vmovups	%ymm14, -0x1b0(%rbp)
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x230(%rbp)
               	vmovdqu	-0x1b0(%rbp), %xmm0
               	vmovdqu	-0x1d0(%rbp), %xmm1
               	vpermilps	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x120(%rsp), %rdi
               	leaq	-0x188(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x230(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x230(%rbp)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	-0x1e0(%rbp), %xmm14
               	vmovq	%xmm14, %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	movq	-0x48(%rbp,%rcx,8), %rax
               	movq	%rax, -0x148(%rbp)
               	movups	-0x1f0(%rbp), %xmm14
               	vpextrq	$0x1, %xmm14, %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	movq	-0x48(%rbp,%rcx,8), %rax
               	movq	%rax, -0x140(%rbp)
               	movups	-0x208(%rbp), %xmm14
               	vmovq	%xmm14, %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	orq	$0x2, %rcx
               	movq	-0x48(%rbp,%rcx,8), %rax
               	movq	%rax, -0x138(%rbp)
               	movups	-0x228(%rbp), %xmm14
               	vpextrq	$0x1, %xmm14, %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	orq	$0x2, %rcx
               	movq	-0x48(%rbp,%rcx,8), %rax
               	movq	%rax, -0x130(%rbp)
               	vmovups	-0x1b0(%rbp), %ymm14
               	vmovups	-0x1d0(%rbp), %ymm15
               	vpermilpd	%ymm15, %ymm14, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	-0x128(%rbp), %rax
               	vmovups	%ymm0, (%rax)
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x230(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d8(%rbp)
               	vmovdqu	-0x1b0(%rbp), %xmm0
               	vmovdqu	-0x1d0(%rbp), %xmm1
               	vpermilpd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movl	$0x10, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d8(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	%rax, -0x148(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, -0x140(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x138(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x130(%rbp)
               	vmovups	-0x1b0(%rbp), %ymm14
               	vpermq	$0x9c, %ymm14, %ymm0    # ymm0 = ymm14[0,3,1,2]
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x148(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d8(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d8(%rbp)
               	andq	$0x7, %rbx
               	movl	-0x68(%rbp,%rbx,4), %eax
               	movl	%eax, -0x188(%rbp)
               	andq	$0x7, %r12
               	movl	-0x68(%rbp,%r12,4), %eax
               	movl	%eax, -0x184(%rbp)
               	andq	$0x7, %r13
               	movl	-0x68(%rbp,%r13,4), %eax
               	movl	%eax, -0x180(%rbp)
               	andq	$0x7, %r14
               	movl	-0x68(%rbp,%r14,4), %eax
               	movl	%eax, -0x17c(%rbp)
               	andq	$0x7, %r15
               	movl	-0x68(%rbp,%r15,4), %eax
               	movl	%eax, -0x178(%rbp)
               	movq	-0x1f8(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %ecx
               	movl	%ecx, -0x174(%rbp)
               	movq	-0x210(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %ecx
               	movl	%ecx, -0x170(%rbp)
               	movq	-0x218(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %eax
               	movl	%eax, -0x16c(%rbp)
               	leaq	(%rsp), %rdi
               	vmovups	-0x1b0(%rbp), %ymm14
               	vmovups	-0x1d0(%rbp), %ymm15
               	vpermd	%ymm14, %ymm15, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x188(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d8(%rbp), %rbx
               	orq	%rax, %rbx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm0
               	leaq	-0x108(%rbp), %rsi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	-0xe8(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	-0xc8(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vroundps	$0x8, %ymm0, %ymm1
               	leaq	0x40(%rsp), %rdi
               	vmovups	%ymm1, 0x40(%rsp)
               	vroundps	$0x1, %ymm0, %ymm1
               	vmovups	%ymm1, 0x60(%rsp)
               	vroundps	$0x2, %ymm0, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0xe8(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	-0xc8(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm0
               	leaq	-0xa8(%rbp), %rsi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vroundpd	$0x3, %ymm0, %ymm1
               	leaq	0xa0(%rsp), %rdi
               	vmovups	%ymm1, 0xa0(%rsp)
               	vroundpd	$0x2, %ymm0, %ymm1
               	vmovups	%ymm1, 0xc0(%rsp)
               	vroundpd	$0x1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	-0x88(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm0
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm1
               	vdpps	$0xb5, %ymm1, %ymm0, %ymm0
               	leaq	0x100(%rsp), %rdi
               	vmovups	%ymm0, 0x100(%rsp)
               	leaq	-0x48(%rbp), %rsi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	movl	$0x80, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x260(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	xorl	%edi, %edi
               	callq	<addr>
               	orq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0xc8, %ebx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
