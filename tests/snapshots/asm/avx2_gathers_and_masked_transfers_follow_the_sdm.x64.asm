
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
               	subq	$0x58, %rsp
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movl	0x48(%rsp), %edx
               	movl	%edx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	(%rsp,%rax,4), %edx
               	movl	%edx, 0x48(%rsp)
               	movl	0x10(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x48(%rsp), %r10
               	movslq	0x30(%rsp,%rax,4), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movl	(%rdx), %r11d
               	movl	%r11d, (%r10)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r10
               	movslq	0x40(%rsp,%rax,4), %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	movl	(%r8), %r11d
               	movl	%r11d, (%r10)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leave
               	retq

<_mm_i32gather_epi64>:
               	subq	$0x58, %rsp
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x48(%rsp), %rdx
               	movq	%rdx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x48(%rsp), %r10
               	movslq	0x30(%rsp,%rax,4), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movq	(%rdx), %r11
               	movq	%r11, (%r10)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r10
               	movslq	0x60(%rsp,%rax,4), %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	movq	(%r8), %r11
               	movq	%r11, (%r10)
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leave
               	retq

<_mm_i64gather_epi32>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movl	0x48(%rsp), %edx
               	movl	%edx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	(%rsp,%rax,4), %edx
               	movl	%edx, 0x48(%rsp)
               	movl	0x10(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	movq	-0x50(%rsp), %r10
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	vmovups	%ymm0, (%rsp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %edx
               	movl	%edx, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %edx
               	movl	%edx, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %edx
               	nopl	(%rax,%rax)
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	pushq	%r10
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	popq	%r10
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	vzeroupper
               	leave
               	retq

<_mm_i64gather_epi64>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x48(%rsp), %rdx
               	movq	%rdx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movq	(%rdx), %r10
               	movq	%r10, (%r11)
               	movq	-0x50(%rsp), %r10
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	leaq	0x20(%rsp), %r8
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%r8)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%r9, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x60(%rsp,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	pushq	%r10
               	movq	(%r9), %r10
               	movq	%r10, (%r11)
               	popq	%r10
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leave
               	retq

<_mm_i32gather_ps>:
               	subq	$0x58, %rsp
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movl	0x48(%rsp), %edx
               	movl	%edx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	(%rsp,%rax,4), %edx
               	movl	%edx, 0x48(%rsp)
               	movl	0x10(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x48(%rsp), %r10
               	movslq	0x30(%rsp,%rax,4), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movl	(%rdx), %r11d
               	movl	%r11d, (%r10)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0x60(%rsp,%rax,4), %r8d
               	movl	%r8d, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r8d
               	testl	%r8d, %r8d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r10
               	movslq	0x40(%rsp,%rax,4), %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	movl	(%r8), %r11d
               	movl	%r11d, (%r10)
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
               	leave
               	retq

<_mm_i32gather_pd>:
               	subq	$0x58, %rsp
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x48(%rsp), %rdx
               	movq	%rdx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x48(%rsp), %r10
               	movslq	0x30(%rsp,%rax,4), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdi, %rdx
               	movq	(%rdx), %r11
               	movq	%r11, (%r10)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %r8
               	movq	%r8, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	leaq	-0x8(%rbp), %r10
               	movslq	0x60(%rsp,%rax,4), %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	movq	(%r8), %r11
               	movq	%r11, (%r10)
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leave
               	retq

<_mm_mask_i64gather_ps>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	movups	%xmm0, (%rsp)
               	movups	%xmm2, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm1, 0x30(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	0x48(%rsp), %edx
               	movl	%edx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	(%rsp,%rax,4), %edx
               	movl	%edx, 0x48(%rsp)
               	movl	0x10(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	movq	-0x50(%rsp), %r10
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm_i64gather_ps>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movl	0x48(%rsp), %edx
               	movl	%edx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	(%rsp,%rax,4), %edx
               	movl	%edx, 0x48(%rsp)
               	movl	0x10(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	movq	-0x50(%rsp), %r10
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_mask_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm2, 0x30(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	vmovups	%ymm1, (%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x8(%rbp), %edx
               	movl	%edx, 0x40(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %edx
               	movl	%edx, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	pushq	%r10
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	popq	%r10
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	vzeroupper
               	leave
               	retq

<_mm256_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	vmovups	%ymm0, (%rsp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %edx
               	movl	%edx, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x20(%rsp,%rax,4), %edx
               	movl	%edx, -0x8(%rbp)
               	movl	0x30(%rsp,%rax,4), %edx
               	nopl	(%rax,%rax)
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	pushq	%r10
               	movl	(%rdx), %r10d
               	movl	%r10d, (%r11)
               	popq	%r10
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm0
               	vzeroupper
               	leave
               	retq

<_mm_mask_i64gather_pd>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	movups	%xmm0, (%rsp)
               	movups	%xmm2, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm1, 0x30(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	0x48(%rsp), %rdx
               	movq	%rdx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movq	(%rdx), %r10
               	movq	%r10, (%r11)
               	movq	-0x50(%rsp), %r10
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm_i64gather_pd>:
               	subq	$0x58, %rsp
               	movslq	%esi, %rsi
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x48(%rsp), %rdx
               	movq	%rdx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x48(%rsp), %r11
               	movq	0x30(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	movq	%r10, -0x50(%rsp)
               	movq	(%rdx), %r10
               	movq	%r10, (%r11)
               	movq	-0x50(%rsp), %r10
               	jmp	<addr>
               	movups	0x20(%rsp), %xmm0
               	addq	$0x58, %rsp
               	retq

<_mm256_mask_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movslq	%esi, %rsi
               	vmovups	%ymm0, (%rsp)
               	vmovups	%ymm2, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0x60(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, 0x40(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rsp,%rax,8), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %rdx
               	nopw	(%rax,%rax)
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	0x60(%rsp,%rax,8), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdi, %rdx
               	pushq	%r10
               	movq	(%rdx), %r10
               	movq	%r10, (%r11)
               	popq	%r10
               	nop
               	jmp	<addr>
               	vmovups	0x40(%rsp), %ymm0
               	leave
               	retq

<_mm256_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	leaq	0x20(%rsp), %r8
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%r8)
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%r9, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x60(%rsp,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	0x40(%rsp,%rax,8), %r9
               	imulq	%rsi, %r9
               	addq	%rdi, %r9
               	pushq	%r10
               	movq	(%r9), %r10
               	movq	%r10, (%r11)
               	popq	%r10
               	jmp	<addr>
               	vmovups	0x20(%rsp), %ymm0
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
               	movq	%r12, %rdi
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	callq	<addr>
               	leaq	0x40(%r12), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdx,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
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
               	movl	$0x1, %esi
               	nopl	(%rax,%rax)
               	cmpl	$0x0, 0x38(%rsp)
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
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rdi
               	movq	%rcx, %r8
               	shlq	%r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	subq	%rcx, %rdx
               	movq	%r13, %rcx
               	imulq	%rbp, %rcx
               	xorl	%eax, %eax
               	nopl	(%rax)
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r10
               	shlq	$0x3, %r10
               	movslq	%r10d, %r10
               	shrxq	%r10, %rdx, %r10
               	andq	$0xff, %r10
               	movb	%r10b, (%r12,%rdi)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x30(%rsp), %r10
               	shlxq	%r10, %rax, %r11
               	movq	%rbx, %rcx
               	imulq	%rbp, %rcx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r10
               	shlq	$0x3, %r10
               	movslq	%r10d, %r10
               	shrxq	%r10, %r11, %r10
               	andq	$0xff, %r10
               	movb	%r10b, (%r14,%rdi)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%ebx, %eax
               	jl	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	imulq	0x48(%rsp), %rax
               	movq	$0x0, 0x58(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movq	0x58(%rsp), %r10
               	movq	%rbx, %rcx
               	imulq	%rbp, %rcx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdx
               	movslq	%edx, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %r10, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r15,%rdi)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	%ebx, %eax
               	jl	<addr>
               	jmp	<addr>
               	leaq	0x40(%r12), %rax
               	movq	$0x0, 0x58(%rsp)
               	movq	%rbx, %rcx
               	imulq	%rbp, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movq	0x58(%rsp), %r10
               	jmp	<addr>
               	movl	$0x7f, %r11d
               	nop
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xe0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x140(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x40(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x150(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x60(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xe0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xc0(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r9, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x1, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x1, %esi
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x1, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
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
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movl	$0x1, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x140(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopw	(%rax,%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x40(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x150(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x60(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xc0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r9, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x2, %esi
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
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
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movl	$0x2, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopw	(%rax,%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x130(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x20(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x140(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	leaq	0x40(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0x100(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x40(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x150(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x4, %r8d
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
               	leaq	0x60(%rsp), %r10
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r10)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nop
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x2, %rcx
               	addq	%r10, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0x100(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x2, %rcx
               	addq	%r10, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x4, %esi
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x4, %r8d
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
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movl	$0x4, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0x100(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r10, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0x100(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r10, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x40(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x8, %r8d
               	vzeroupper
               	callq	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	-0x60(%rbp), %ymm0
               	vmovups	-0x40(%rbp), %ymm1
               	testl	%r12d, %r12d
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	vmovups	%ymm1, 0x80(%rsp)
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm2, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm1, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x3, %rcx
               	addq	%r10, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x80(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm2
               	movups	%xmm1, 0xe0(%rsp)
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	movups	%xmm2, 0xa0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x3, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x130(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x130(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r10
               	leaq	0x100(%rsp), %rax
               	vmovups	(%r9), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm1, 0xe0(%rsp)
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	$0x3, %rcx
               	addq	%r10, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	vmovups	0xc0(%rsp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x20(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x8, %esi
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x150(%rsp), %rdi
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
               	movq	%r12, %r9
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x8, %ecx
               	movl	$0x8, %r8d
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
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	movq	%rcx, %r10
               	vmovups	(%r10), %ymm2
               	movl	$0x8, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xc0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
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
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x8, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x8, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x4, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x4, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x4, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x4, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x4, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%r8, %rsi
               	movq	(%rsi), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%r9, %rsi
               	movl	(%rsi), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%r8, %rsi
               	movq	(%rsi), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	nop
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%r9, %rsi
               	movl	(%rsi), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	$0x2, %rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x2, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x2, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x2, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
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
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rsi
               	shlq	%rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rdi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%r8)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r9, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	movups	0x80(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movq	0xa0(%rsp,%rax,8), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%r8, %rsi
               	movq	(%rsi), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	nop
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%r9, %rsi
               	movl	(%rsi), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xe0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%r8, %rsi
               	movq	(%rsi), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rcx
               	movq	%rcx, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rcx
               	nop
               	testq	%rcx, %rcx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rdi)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rsi
               	shlq	%rsi
               	addq	%r9, %rsi
               	movl	(%rsi), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rcx)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %ecx
               	movl	%ecx, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %ecx
               	nopl	(%rax)
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movslq	0xa0(%rsp,%rax,4), %rcx
               	shlq	%rcx
               	addq	%r8, %rcx
               	movl	(%rcx), %r11d
               	movl	%r11d, (%rdi)
               	nop
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x1, %esi
               	callq	<addr>
               	vmovups	%ymm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x1, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movl	$0x1, %esi
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movl	$0x1, %esi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
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
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r9, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	xorl	%eax, %eax
               	leaq	0xc0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movq	%rax, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0x80(%rsp), %rdi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rdi)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0x80(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x100(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0xe0(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0x80(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	xorl	%eax, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	vmovd	%ecx, %xmm1
               	vpinsrd	$0x1, %ecx, %xmm1, %xmm1
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movq	0xa0(%rsp,%rax,8), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xe0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nop
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nopl	(%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
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
               	leaq	0xa0(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x80(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0xc0(%rsp), %rdx
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xa0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	%xmm0, 0xe0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xa0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	0x80(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0xc0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xe0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nop
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, 0xc0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	0xe0(%rsp,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	0x80(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r11
               	movq	%r11, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0xc0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %r9
               	leaq	0xa0(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	$-0x1, 0x80(%rsp)
               	movq	$-0x1, 0x88(%rsp)
               	movq	$-0x1, 0x90(%rsp)
               	movq	$-0x1, 0x98(%rsp)
               	leaq	0xc0(%rsp), %rdx
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0x100(%rsp), %rsi
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdi)
               	leaq	0xe0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rdi), %ymm14
               	vmovups	%ymm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %r8
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%r8)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r9, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	vmovups	0xc0(%rsp), %ymm0
               	leaq	0xa0(%rsp), %rax
               	vmovups	%ymm0, 0xa0(%rsp)
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %r8
               	movups	0x120(%rsp), %xmm0
               	vpcmpeqd	%xmm1, %xmm1, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rsi)
               	movups	%xmm0, 0xa0(%rsp)
               	jmp	<addr>
               	movl	-0x88(%rbp), %edi
               	movl	%edi, 0xc0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0xe0(%rsp,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	nop
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	movslq	0xa0(%rsp,%rax,4), %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r11d
               	movl	%r11d, (%rsi)
               	nopl	(%rax)
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
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0xa0(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x80(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x60(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
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
               	movq	%rbx, %rcx
               	imulq	%r13, %rcx
               	leaq	(%rcx,%rbx), %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	movzbq	-0x60(%rbp,%rdx), %rax
               	testb	$-0x80, %al
               	je	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movq	$0x0, -0xa8(%rbp)
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	leaq	-0xa8(%rbp), %rdi
               	vzeroupper
               	nopl	(%rax)
               	callq	<addr>
               	movq	-0xa8(%rbp), %rsi
               	movq	%rbx, %rdi
               	imulq	%r13, %rdi
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movslq	%edx, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rcx
               	nop
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	xorl	%esi, %esi
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
               	nopl	(%rax)
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %r8
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x370(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	-0xe8(%rbp), %edi
               	movl	%edi, 0x380(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	%ecx, -0xe8(%rbp)
               	movl	0x370(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	jmp	<addr>
               	movups	0x380(%rsp), %xmm0
               	movups	%xmm0, 0x360(%rsp)
               	leaq	-0xa0(%rbp), %r8
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x390(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	nopl	(%rax)
               	jmp	<addr>
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, 0x3a0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	%ecx, -0xe0(%rbp)
               	movl	0x390(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	nop
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
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	leaq	-0xa8(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	movq	-0xa8(%rbp), %rsi
               	movq	%rbx, %rdi
               	imulq	%r13, %rdi
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movslq	%edx, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%r8)
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rax
               	nopl	(%rax,%rax)
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
               	nop
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
               	movq	%r14, %rdx
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	nopl	(%rax)
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
               	nopl	(%rax,%rax)
               	testl	%esi, %esi
               	jge	<addr>
               	movl	0x420(%rsp,%rcx,4), %esi
               	movl	%esi, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	nopw	(%rax,%rax)
               	testq	%r12, %r12
               	je	<addr>
               	leaq	(%rsp), %rdx
               	leaq	0x1e0(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x200(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x220(%rsp)
               	xorl	%ecx, %ecx
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movl	0x200(%rsp,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	movl	0x220(%rsp,%rcx,4), %esi
               	movl	%esi, -0x20(%rbp,%rcx,4)
               	jmp	<addr>
               	leaq	(%rsp), %rdx
               	leaq	0x240(%rsp), %rcx
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x260(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	vmovups	-0x130(%rbp), %ymm14
               	vmovups	%ymm14, 0x280(%rsp)
               	xorl	%ecx, %ecx
               	nopl	(%rax)
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movl	0x260(%rsp,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	movl	0x280(%rsp,%rcx,4), %esi
               	movl	%esi, -0x20(%rbp,%rcx,4)
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
               	nop
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
               	nop
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
               	nopl	(%rax)
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
               	nopl	(%rax)
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
               	leaq	-0xa0(%rbp), %r8
               	leaq	0x60(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x80(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	nopl	(%rax)
               	jmp	<addr>
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, 0xa0(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	%ecx, -0xd8(%rbp)
               	movl	0x80(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	nop
               	jmp	<addr>
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	-0xa0(%rbp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0xc0(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xe0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	-0xd0(%rbp), %edi
               	movl	%edi, 0x100(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movl	%ecx, -0xd0(%rbp)
               	movl	0xe0(%rsp,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%r8, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
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
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %r8
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x3b0(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rdi
               	movq	%rdi, 0x3c0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rcx, -0xc8(%rbp)
               	movq	0x3b0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	jmp	<addr>
               	movups	0x3c0(%rsp), %xmm0
               	movups	%xmm0, 0x360(%rsp)
               	leaq	-0xa0(%rbp), %r8
               	movups	-0x100(%rbp), %xmm14
               	movups	%xmm14, 0x3d0(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	nop
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, 0x3e0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rcx, -0xc0(%rbp)
               	movq	0x3d0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
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
               	leaq	-0xa0(%rbp), %r8
               	leaq	0x120(%rsp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x140(%rsp), %rdx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rdi
               	movq	%rdi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rcx, -0xb8(%rbp)
               	movq	0x140(%rsp,%rax,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	vmovups	0x160(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	leaq	-0xa0(%rbp), %r8
               	leaq	(%rsp), %rcx
               	leaq	0x180(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x1a0(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, 0x1c0(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rcx, -0xb0(%rbp)
               	movq	0x1a0(%rsp,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
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
               	nopw	(%rax,%rax)
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
               	leaq	(%rsp), %rcx
               	movw	%ax, 0x1e(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
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
               	leaq	(%rsp), %rcx
               	movw	%ax, 0x1e(%rsp)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
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
               	leaq	(%rsp), %rcx
               	movq	%rax, (%rsp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, 0x8(%rsp)
               	movq	-0x30(%rbp), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	-0x28(%rbp), %rax
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
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movzwq	0x20(%rsp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movswq	-0x60(%rbp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %ecx
               	movl	$0x1, %eax
               	jne	<addr>
               	movzwq	0x32(%rsp), %rsi
               	movswq	-0x4e(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %esi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzwq	0x3e(%rsp), %rcx
               	movswq	-0x42(%rbp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%eax, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x20(%rbp), %rsi
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rsi)
               	movq	-0x40(%rbp), %rax
               	movw	%ax, -0x6(%rbp)
               	vmovups	0x20(%rsp), %ymm0
               	movswq	%ax, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpinsrw	$0x5, %eax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	(%rsp), %rdi
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
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0xa0(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rsi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp,%rcx)
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x20, %ecx
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
               	vmovups	%ymm0, (%rsp)
               	leaq	-0x60(%rbp), %rsi
               	addq	$0x3, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rcx
               	incq	%rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	(%rsp), %rdi
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
               	vmovups	%ymm2, 0x20(%rsp)
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
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
               	leaq	-0x40(%rbp), %rax
               	movsd	(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movsd	0x10(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	movups	%xmm0, -0x3b(%rbp)
               	vmovq	%xmm2, %xmm0            # xmm0 = xmm2[0],zero
               	vunpcklpd	%xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm3[0]
               	movups	%xmm0, -0x1f(%rbp)
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
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x40(%rbp), %rdi
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
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x40(%rbp), %rdi
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
               	leaq	0x20(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	vmovups	0x20(%rax), %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	vmovups	-0x80(%rbp), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %rdi
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
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rdx, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x40(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rax
               	movq	%rax, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rax
               	movq	%rax, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rdi, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp,%rcx)
               	incq	%rcx
               	nop
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x2545f4914f6cdd1d, %r8 # imm = 0x2545F4914F6CDD1D
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%r8, %rax
               	shrq	$0x3e, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x20(%rbp,%rcx), %rdi
               	movzbq	-0x40(%rbp,%rcx), %rax
               	xorq	$-0x1, %rax
               	andq	$0xff, %rax
               	andq	%rax, %rdi
               	movb	%dil, -0x20(%rbp,%rcx)
               	jmp	<addr>
               	xorl	%r10d, %r10d
               	movq	%r10, -0xa8(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0xa8(%rbp), %r14
               	movq	-0xa8(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	movq	-0x50(%rbp,%rdx,8), %r13
               	sarq	%rax
               	movq	-0x50(%rbp,%rax,8), %rbx
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movq	%rcx, %rsi
               	movzbq	(%r13,%rax), %rdx
               	movzbq	(%rbx,%rax), %rdi
               	movq	%rdx, %r8
               	andq	%rdi, %r8
               	testl	%r8d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	xorq	$-0x1, %rdx
               	andq	%rdi, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmovups	(%r13), %ymm1
               	vmovups	(%rbx), %ymm2
               	vpand	%ymm2, %ymm1, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%esi, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm1, %ymm0
               	vpand	%ymm2, %ymm0, %ymm0
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rdi
               	orq	%rdi, %rdx
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rdi
               	orq	%rdi, %rdx
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdi
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpl	%ecx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	vpand	%ymm2, %ymm1, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	xorl	%edx, %edx
               	nopl	(%rax)
               	testq	%rax, %rax
               	je	<addr>
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm1, %ymm0
               	vpand	%ymm2, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rdi
               	orq	%rdi, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rdi
               	orq	%rdi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdi
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%esi, %esi
               	cmovneq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movl	$0x4, %r12d
               	movl	$0x10, %r9d
               	nop
               	jmp	<addr>
               	orq	%rax, %r14
               	addq	$0x10, %r9
               	cmpl	$0x20, %r9d
               	jg	<addr>
               	movl	$0x1, %edx
               	leaq	-0x1(%r12), %rax
               	movq	%rdx, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movzbq	(%r13,%rax), %rcx
               	movzbq	(%rbx,%rax), %rdi
               	movq	%rcx, %r8
               	andq	%rdi, %r8
               	andq	$0x80, %r8
               	testl	%r8d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	xorq	$-0x1, %rcx
               	andq	%rdi, %rcx
               	andq	$0x80, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rdx
               	addq	%r12, %rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	cmpl	$0x4, %r12d
               	jne	<addr>
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %r9d
               	jne	<addr>
               	movups	(%r13), %xmm0
               	movups	(%rbx), %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x1, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x2, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x3, %xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	vmovd	%xmm1, %edi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrd	$0x1, %xmm0, %edi
               	movslq	%edi, %rdi
               	xorq	$-0x1, %rdi
               	vpextrd	$0x1, %xmm1, %r8d
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	vpextrd	$0x2, %xmm0, %edi
               	movslq	%edi, %rdi
               	xorq	$-0x1, %rdi
               	vpextrd	$0x2, %xmm1, %r8d
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	vpextrd	$0x3, %xmm0, %edi
               	movslq	%edi, %rdi
               	xorq	$-0x1, %rdi
               	vpextrd	$0x3, %xmm1, %r8d
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	vmovd	%xmm0, %edi
               	movslq	%edi, %rdi
               	vmovd	%xmm1, %r8d
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	vpextrd	$0x1, %xmm0, %edi
               	movslq	%edi, %rdi
               	vpextrd	$0x1, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	vpextrd	$0x2, %xmm0, %edi
               	movslq	%edi, %rdi
               	vpextrd	$0x2, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	vpextrd	$0x3, %xmm0, %edi
               	movslq	%edi, %rdi
               	vpextrd	$0x3, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	xorl	%edi, %edi
               	testl	%r8d, %r8d
               	jne	<addr>
               	vmovd	%xmm0, %edi
               	movslq	%edi, %rdi
               	xorq	$-0x1, %rdi
               	vmovd	%xmm1, %r8d
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	vpextrd	$0x1, %xmm0, %r8d
               	movslq	%r8d, %r8
               	xorq	$-0x1, %r8
               	vpextrd	$0x1, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	vpextrd	$0x2, %xmm0, %r8d
               	movslq	%r8d, %r8
               	xorq	$-0x1, %r8
               	vpextrd	$0x2, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	vpextrd	$0x3, %xmm0, %r8d
               	movslq	%r8d, %r8
               	xorq	$-0x1, %r8
               	vpextrd	$0x3, %xmm1, %r10d
               	movslq	%r10d, %r10
               	andq	%r10, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	testl	%edi, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movl	$0x1, %r8d
               	cmpl	%edx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	%esi, %ecx
               	cmoveq	%rax, %r8
               	movl	$0x1, %eax
               	nopl	(%rax,%rax)
               	testq	%r8, %r8
               	jne	<addr>
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%esi, %esi
               	cmoveq	%rcx, %rax
               	cmpl	%eax, %edi
               	setne	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	cmpl	$0x4, %r12d
               	jne	<addr>
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%r9, -0xc0(%rbp)
               	movq	%r12, -0xc8(%rbp)
               	movq	%r14, -0xd0(%rbp)
               	leaq	(%rsp), %rax
               	vmovups	(%r13), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %edi
               	movl	0x8(%rsp), %r8d
               	movl	0xc(%rsp), %r15d
               	movl	0x10(%rsp), %edx
               	movl	0x14(%rsp), %esi
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r12d
               	movl	(%rbx), %ecx
               	movl	0x4(%rbx), %r14d
               	movl	0x8(%rbx), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0xc(%rbx), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x10(%rbx), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x14(%rbx), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x18(%rbx), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x1c(%rbx), %r10d
               	movq	%r10, -0x80(%rbp)
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	movslq	%edi, %rax
               	movslq	%r14d, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%r8d, %rax
               	movq	-0x58(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%r15d, %rax
               	movq	-0x60(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%edx, %rax
               	movq	-0x68(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%esi, %rax
               	movq	-0x70(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%r9d, %rax
               	movq	-0x78(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movslq	%r12d, %rax
               	movq	-0x80(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %edi
               	movl	0x8(%rsp), %r8d
               	movl	0xc(%rsp), %r15d
               	movl	0x10(%rsp), %edx
               	movl	0x14(%rsp), %esi
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r12d
               	movl	0x20(%rsp), %r14d
               	movl	0x24(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movslq	%r14d, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%edi, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x58(%rbp), %r10
               	movslq	%r10d, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%r8d, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x60(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%r15d, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x68(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%edx, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x70(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%esi, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x78(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%r9d, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x80(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movslq	%r12d, %rdi
               	xorq	$-0x1, %rdi
               	movq	-0x88(%rbp), %r8
               	movslq	%r8d, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movl	(%rsp), %edi
               	movl	0x4(%rsp), %edx
               	movl	0x8(%rsp), %esi
               	movl	0xc(%rsp), %r9d
               	movl	0x10(%rsp), %r12d
               	movl	0x14(%rsp), %r14d
               	movl	0x18(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x1c(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x20(%rsp), %r8d
               	movl	0x24(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movslq	%edi, %r15
               	movslq	%r8d, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	%r15, %rdi
               	andq	-0x68(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movslq	%edx, %rdx
               	movq	-0x70(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	movq	%rdx, %rdi
               	andq	-0x70(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movslq	%esi, %rsi
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	movq	%rsi, %rdi
               	andq	-0x78(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movslq	%r9d, %r9
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	movq	%r9, %rdi
               	andq	-0x80(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movslq	%r12d, %r12
               	movq	-0x88(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	%r12, %rdi
               	andq	-0x88(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movslq	%r14d, %r14
               	movq	-0x90(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x90(%rbp)
               	movq	%r14, %rdi
               	andq	-0x90(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movq	-0x58(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x98(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x98(%rbp)
               	movq	-0x58(%rbp), %rdi
               	andq	-0x98(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movq	-0x60(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0xa0(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0xa0(%rbp)
               	movq	-0x60(%rbp), %rdi
               	andq	-0xa0(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	xorl	%edi, %edi
               	nopl	(%rax,%rax)
               	testl	%r8d, %r8d
               	jne	<addr>
               	xorq	$-0x1, %r15
               	andq	-0x68(%rbp), %r15
               	testq	%r15, %r15
               	setge	%dil
               	movzbq	%dil, %rdi
               	xorq	$-0x1, %rdx
               	andq	-0x70(%rbp), %rdx
               	testq	%rdx, %rdx
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %rsi
               	andq	-0x78(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %r9
               	andq	-0x80(%rbp), %r9
               	testq	%r9, %r9
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %r12
               	andq	-0x88(%rbp), %r12
               	testq	%r12, %r12
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %r14
               	andq	-0x90(%rbp), %r14
               	testq	%r14, %r14
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, -0x58(%rbp)
               	movq	-0x58(%rbp), %r10
               	andq	-0x98(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	%r10, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, -0x60(%rbp)
               	movq	-0x60(%rbp), %r10
               	andq	-0xa0(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	%r10, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	testl	%edi, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xb8(%rbp), %rsi
               	movq	-0xc0(%rbp), %r9
               	movq	-0xc8(%rbp), %r12
               	movq	-0xd0(%rbp), %r14
               	jmp	<addr>
               	cmpl	$0x10, %r9d
               	jne	<addr>
               	movups	(%r13), %xmm0
               	movups	(%rbx), %xmm1
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	vpextrq	$0x1, %xmm0, %rax
               	vpextrq	$0x1, %xmm1, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	vmovq	%xmm0, %rax
               	xorq	$-0x1, %rax
               	vmovq	%xmm1, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	vpextrq	$0x1, %xmm0, %rdi
               	xorq	$-0x1, %rdi
               	vpextrq	$0x1, %xmm1, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	vmovq	%xmm0, %rdi
               	vmovq	%xmm1, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	vpextrq	$0x1, %xmm0, %rdi
               	vpextrq	$0x1, %xmm1, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	xorl	%edi, %edi
               	testl	%r8d, %r8d
               	jne	<addr>
               	vmovq	%xmm0, %rdi
               	xorq	$-0x1, %rdi
               	vmovq	%xmm1, %r8
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	vpextrq	$0x1, %xmm0, %rdi
               	xorq	$-0x1, %rdi
               	vpextrq	$0x1, %xmm1, %r10
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	testl	%r8d, %r8d
               	sete	%dil
               	movzbq	%dil, %rdi
               	jmp	<addr>
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%r9, -0xc0(%rbp)
               	movq	%r12, -0xc8(%rbp)
               	movq	%r14, -0xd0(%rbp)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%r13), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x60(%rsp), %rax
               	vmovups	(%rbx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdi
               	movq	0x50(%rsp), %r8
               	movq	0x58(%rsp), %r10
               	movq	(%rbx), %rcx
               	movq	0x8(%rbx), %r11
               	movq	0x10(%rbx), %r15
               	movq	0x18(%rbx), %rdx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%r11, %rdi
               	testq	%rdi, %rdi
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	andq	%r15, %r8
               	testq	%r8, %r8
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	andq	%rdx, %r10
               	testq	%r10, %r10
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rcx
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdi
               	movq	0x50(%rsp), %r8
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	0x68(%rsp), %r15
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	xorq	$-0x1, %rax
               	andq	%r11, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rdi
               	andq	%r15, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	xorq	$-0x1, %r8
               	andq	%rdx, %r8
               	testq	%r8, %r8
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	xorq	$-0x1, %r10
               	andq	%rsi, %r10
               	testq	%r10, %r10
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rax
               	movq	0x40(%rsp), %r15
               	movq	0x48(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %r9
               	movq	0x60(%rsp), %r12
               	movq	0x68(%rsp), %r14
               	movq	0x70(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	%r15, %rdi
               	andq	%r12, %rdi
               	testq	%rdi, %rdi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rdi
               	andq	%r14, %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movq	%rsi, %rdi
               	andq	-0x58(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	movq	%r9, %rdi
               	andq	-0x60(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %r8
               	xorl	%edi, %edi
               	nopw	(%rax,%rax)
               	testl	%r8d, %r8d
               	jne	<addr>
               	xorq	$-0x1, %r15
               	andq	%r12, %r15
               	testq	%r15, %r15
               	setge	%dil
               	movzbq	%dil, %rdi
               	xorq	$-0x1, %rdx
               	andq	%r14, %rdx
               	testq	%rdx, %rdx
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %rsi
               	andq	-0x58(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	xorq	$-0x1, %r9
               	andq	-0x60(%rbp), %r9
               	testq	%r9, %r9
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	testl	%edi, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xb8(%rbp), %rsi
               	movq	-0xc0(%rbp), %r9
               	movq	-0xc8(%rbp), %r12
               	movq	-0xd0(%rbp), %r14
               	jmp	<addr>
               	addq	$0x4, %r12
               	cmpl	$0x8, %r12d
               	jle	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$0x1, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %rax
               	nopl	(%rax)
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
               	movabsq	$0x2545f4914f6cdd1d, %r12 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r12
               	vmovd	%r12d, %xmm0
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
               	movabsq	$0x2545f4914f6cdd1d, %r13 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r13
               	vpinsrd	$0x1, %r13d, %xmm0, %xmm0
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
               	movabsq	$0x2545f4914f6cdd1d, %r14 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r14
               	movapd	%xmm0, %xmm1
               	vpinsrd	$0x2, %r14d, %xmm1, %xmm1
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
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r15 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r15
               	vpinsrd	$0x3, %r15d, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm4
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
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vmovd	%ecx, %xmm2
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
               	movl	%eax, -0x54(%rbp)
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
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rdx
               	vpinsrd	$0x1, %edx, %xmm2, %xmm2
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x50(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rsi
               	movapd	%xmm2, %xmm3
               	vpinsrd	$0x2, %esi, %xmm3, %xmm3
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x4c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	vpinsrd	$0x3, %eax, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm4, %ymm4
               	vmovups	-0x68(%rbp), %ymm5
               	movq	%r12, %r8
               	andq	$0x3, %r8
               	movl	-0x68(%rbp,%r8,4), %edi
               	movl	%edi, -0x188(%rbp)
               	movq	%r13, %r8
               	andq	$0x3, %r8
               	movl	-0x68(%rbp,%r8,4), %edi
               	movl	%edi, -0x184(%rbp)
               	movq	%r14, %r8
               	andq	$0x3, %r8
               	movl	-0x68(%rbp,%r8,4), %edi
               	movl	%edi, -0x180(%rbp)
               	movq	%r15, %r8
               	andq	$0x3, %r8
               	movl	-0x68(%rbp,%r8,4), %edi
               	movl	%edi, -0x17c(%rbp)
               	movq	%rcx, %rdi
               	andq	$0x3, %rdi
               	orq	$0x4, %rdi
               	movl	-0x68(%rbp,%rdi,4), %edi
               	movl	%edi, -0x178(%rbp)
               	movq	%rdx, %rdi
               	andq	$0x3, %rdi
               	orq	$0x4, %rdi
               	movl	-0x68(%rbp,%rdi,4), %edi
               	movl	%edi, -0x174(%rbp)
               	movq	%rsi, %rdi
               	andq	$0x3, %rdi
               	orq	$0x4, %rdi
               	movl	-0x68(%rbp,%rdi,4), %edi
               	movl	%edi, -0x170(%rbp)
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	orq	$0x4, %rdi
               	movl	-0x68(%rbp,%rdi,4), %edi
               	movl	%edi, -0x16c(%rbp)
               	vpermilps	%ymm4, %ymm5, %ymm6
               	vmovups	%ymm6, (%rsp)
               	leaq	-0x168(%rbp), %rdi
               	vmovups	%ymm6, (%rdi)
               	movups	%xmm0, -0x1e0(%rbp)
               	movups	%xmm1, -0x1f0(%rbp)
               	movq	%rcx, -0x1f8(%rbp)
               	movq	%rdx, -0x200(%rbp)
               	movups	%xmm2, -0x210(%rbp)
               	movq	%rsi, -0x218(%rbp)
               	movq	%rax, -0x220(%rbp)
               	movups	%xmm3, -0x230(%rbp)
               	vmovaps	%ymm4, %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovaps	%ymm5, %ymm14
               	vmovups	%ymm14, -0x1b0(%rbp)
               	leaq	-0x168(%rbp), %rdi
               	leaq	-0x188(%rbp), %rsi
               	movl	$0x20, %edx
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
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
               	orq	%rax, %rbx
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	-0x1e0(%rbp), %xmm14
               	vmovq	%xmm14, %rax
               	shrq	%rax
               	andq	$0x1, %rax
               	movq	-0x48(%rbp,%rax,8), %rax
               	movq	%rax, -0x148(%rbp)
               	movups	-0x1f0(%rbp), %xmm14
               	vpextrq	$0x1, %xmm14, %rax
               	shrq	%rax
               	andq	$0x1, %rax
               	movq	-0x48(%rbp,%rax,8), %rax
               	movq	%rax, -0x140(%rbp)
               	movups	-0x210(%rbp), %xmm14
               	vmovq	%xmm14, %rax
               	shrq	%rax
               	andq	$0x1, %rax
               	orq	$0x2, %rax
               	movq	-0x48(%rbp,%rax,8), %rax
               	movq	%rax, -0x138(%rbp)
               	movups	-0x230(%rbp), %xmm14
               	vpextrq	$0x1, %xmm14, %rax
               	shrq	%rax
               	andq	$0x1, %rax
               	orq	$0x2, %rax
               	movq	-0x48(%rbp,%rax,8), %rax
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
               	orq	%rax, %rbx
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
               	orq	%rax, %rbx
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
               	orq	%rax, %rbx
               	andq	$0x7, %r12
               	movl	-0x68(%rbp,%r12,4), %eax
               	movl	%eax, -0x188(%rbp)
               	andq	$0x7, %r13
               	movl	-0x68(%rbp,%r13,4), %eax
               	movl	%eax, -0x184(%rbp)
               	andq	$0x7, %r14
               	movl	-0x68(%rbp,%r14,4), %eax
               	movl	%eax, -0x180(%rbp)
               	andq	$0x7, %r15
               	movl	-0x68(%rbp,%r15,4), %ecx
               	movl	%ecx, -0x17c(%rbp)
               	movq	-0x1f8(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %ecx
               	movl	%ecx, -0x178(%rbp)
               	movq	-0x200(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %eax
               	movl	%eax, -0x174(%rbp)
               	movq	-0x218(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %ecx
               	movl	%ecx, -0x170(%rbp)
               	movq	-0x220(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	-0x68(%rbp,%rcx,4), %eax
               	movl	%eax, -0x16c(%rbp)
               	vmovups	-0x1b0(%rbp), %ymm14
               	vmovups	-0x1d0(%rbp), %ymm15
               	vpermd	%ymm14, %ymm15, %ymm0
               	vmovups	%ymm0, (%rsp)
               	leaq	(%rsp), %rdi
               	leaq	-0x188(%rbp), %rsi
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
               	vmovups	%ymm1, 0x40(%rsp)
               	vroundps	$0x1, %ymm0, %ymm1
               	vmovups	%ymm1, 0x60(%rsp)
               	vroundps	$0x2, %ymm0, %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x40(%rsp), %rdi
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
               	vmovups	%ymm1, 0xa0(%rsp)
               	vroundpd	$0x2, %ymm0, %ymm1
               	vmovups	%ymm1, 0xc0(%rsp)
               	vroundpd	$0x1, %ymm0, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0xa0(%rsp), %rdi
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
               	vmovups	%ymm0, 0x100(%rsp)
               	leaq	-0x48(%rbp), %rsi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	leaq	0x100(%rsp), %rdi
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
               	xorl	%ecx, %ecx
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rax
               	movq	%rax, <rip> # <addr>
               	imulq	%rdx, %rax
               	shrq	$0x20, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x400, %ecx            # imm = 0x400
               	jl	<addr>
               	xorl	%r12d, %r12d
               	movq	%r12, %rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	nopl	(%rax)
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	incq	%r12
               	nopw	%cs:(%rax,%rax)
               	nop
               	cmpl	$0xc8, %r12d
               	jl	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
