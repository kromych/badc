
avx_floating_and_fma_follow_the_sdm.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<_mm256_castsi256_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_extracti128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_set_m128i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x30(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_permute2x128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%esi, %rsi
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %rsi, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	0x60(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %rdx
               	shlq	%rdx
               	testb	$0x8, %cl
               	je	<addr>
               	movq	%rdi, %r8
               	movq	%r8, (%r9,%rdx,8)
               	leaq	0x40(%rsp), %r8
               	incq	%rdx
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x60(%rsp), %r9
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%r9,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rbx
               	andq	$0x1, %rbx
               	shlq	%rbx
               	movq	(%r8,%rbx,8), %r8
               	jmp	<addr>
               	leaq	(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%r8,%rdx,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<__badc_lo_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x20(%rsp)
               	movl	%ecx, 0x24(%rsp)
               	movl	%edx, 0x28(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	%esi, 0x2c(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_hi_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	0x10(%rsp), %eax
               	movl	0x14(%rsp), %ecx
               	movl	0x18(%rsp), %edx
               	movl	0x1c(%rsp), %esi
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x20(%rsp)
               	movl	%ecx, 0x24(%rsp)
               	movl	%edx, 0x28(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	%esi, 0x2c(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_join_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movl	-0x50(%rbp), %ecx
               	movl	-0x4c(%rbp), %edx
               	movl	-0x48(%rbp), %esi
               	movl	-0x44(%rbp), %edi
               	movl	-0x40(%rbp), %r8d
               	movl	-0x3c(%rbp), %r9d
               	movl	-0x38(%rbp), %ebx
               	movl	-0x34(%rbp), %r12d
               	movq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%edi, 0xc(%rax)
               	movl	%r8d, 0x10(%rax)
               	movl	%r9d, 0x14(%rax)
               	movl	%ebx, 0x18(%rax)
               	movl	%r12d, 0x1c(%rax)
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<__badc_lo_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_hi_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_join_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movq	-0x50(%rbp), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	-0x40(%rbp), %rsi
               	movq	-0x38(%rbp), %rdi
               	movq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_add_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	addps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	addps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_add_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	addpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	addpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_sub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	subps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	subps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_sub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	subpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	subpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mul_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	mulps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	mulps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mul_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	mulpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	mulpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_div_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	divps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	divps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_div_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	divpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	divpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_min_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	minps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	minps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_min_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	minpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	minpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_max_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	maxps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	maxps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_max_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	maxpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	maxpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_and_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	andps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	andps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_andnot_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rax
               	movq	%rax, 0x70(%rsp)
               	andq	%rsi, %rcx
               	movq	%rcx, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movq	0x90(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	movq	0x60(%rsp), %rdx
               	movq	0x68(%rsp), %rsi
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rax
               	movq	%rax, 0x70(%rsp)
               	andq	%rsi, %rcx
               	movq	%rcx, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_or_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rax), %xmm14
               	orps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r9
               	leaq	0x90(%rsp), %rcx
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rax), %xmm14
               	orps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_xor_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	xorq	%rdx, %rax
               	movq	%rax, 0x70(%rsp)
               	xorq	%rsi, %rcx
               	movq	%rcx, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movq	0x90(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	movq	0x60(%rsp), %rdx
               	movq	0x68(%rsp), %rsi
               	xorq	%rdx, %rax
               	movq	%rax, 0x70(%rsp)
               	xorq	%rsi, %rcx
               	movq	%rcx, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_addsub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0x60(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb4(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0x68(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0xbc(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0x60(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb4(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0x68(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0xbc(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_addsub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0x60(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0xb8(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0x60(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0xb8(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_hadd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0xb4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0xbc(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0xb4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0xbc(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_hadd_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0xb8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0xb8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_hsub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0xb4(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0xbc(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0xb0(%rsp), %xmm0
               	movss	0xb4(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0xb8(%rsp), %xmm0
               	movss	0xbc(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movss	0x64(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x6c(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_hsub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x60(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0xb8(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0xb0(%rsp), %xmm0
               	movsd	0xb8(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movsd	0x68(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_unpacklo_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	movl	0x60(%rsp), %eax
               	movl	0x64(%rsp), %ecx
               	movl	0x70(%rsp), %edx
               	movl	0x74(%rsp), %esi
               	leaq	0x70(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x70(%rsp)
               	movl	%edx, 0x74(%rsp)
               	movl	%ecx, 0x78(%rsp)
               	movl	%esi, 0x7c(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movl	0x90(%rsp), %eax
               	movl	0x94(%rsp), %ecx
               	movl	0x60(%rsp), %edx
               	movl	0x64(%rsp), %esi
               	leaq	0x70(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x70(%rsp)
               	movl	%edx, 0x74(%rsp)
               	movl	%ecx, 0x78(%rsp)
               	movl	%esi, 0x7c(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_unpackhi_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	movq	0x68(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	leaq	0x70(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x70(%rsp)
               	movq	%rcx, 0x78(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movq	0x98(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	leaq	0x70(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0x70(%rsp)
               	movq	%rcx, 0x78(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_sqrt_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	sqrtps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	sqrtps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_sqrt_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	sqrtpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	sqrtpd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_movehdup_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x74(%rsp), %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x7c(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	%xmm0, 0x4c(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x74(%rsp), %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x7c(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	%xmm0, 0x4c(%rsp)
               	leaq	0x70(%rsp), %r9
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_moveldup_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x70(%rsp), %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x78(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	%xmm0, 0x4c(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x70(%rsp), %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x78(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	%xmm0, 0x4c(%rsp)
               	leaq	0x70(%rsp), %r9
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_movedup_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x70(%rsp), %xmm0
               	movsd	%xmm0, 0x40(%rsp)
               	movsd	%xmm0, 0x48(%rsp)
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x70(%rsp), %xmm0
               	movsd	%xmm0, 0x40(%rsp)
               	movsd	%xmm0, 0x48(%rsp)
               	leaq	0x70(%rsp), %r9
               	movups	0x40(%rsp), %xmm0
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_setr_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rdi, -0x90(%rbp)
               	movq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movss	%xmm0, (%rax)
               	movss	%xmm1, 0x4(%rax)
               	movss	%xmm2, 0x8(%rax)
               	movss	%xmm3, 0xc(%rax)
               	movss	%xmm4, 0x10(%rax)
               	movss	%xmm5, 0x14(%rax)
               	movss	%xmm6, 0x18(%rax)
               	movss	%xmm7, 0x1c(%rax)
               	leave
               	retq

<_mm256_set_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movsd	%xmm3, (%rax)
               	movsd	%xmm2, 0x8(%rax)
               	movsd	%xmm1, 0x10(%rax)
               	movsd	%xmm0, 0x18(%rax)
               	leave
               	retq

<_mm256_set1_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movsd	%xmm0, (%rax)
               	movsd	%xmm0, 0x8(%rax)
               	movsd	%xmm0, 0x10(%rax)
               	movsd	%xmm0, 0x18(%rax)
               	leave
               	retq

<_mm256_set_m128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x30(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_setr_m128d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	leaq	0x30(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_storeu_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leave
               	retq

<_mm256_broadcast_ss>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	(%rsi), %ecx
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	movl	%ecx, 0x10(%rax)
               	movl	%ecx, 0x14(%rax)
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	leave
               	retq

<_mm256_castps_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castpd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castps_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castpd_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castps256_ps128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_castpd256_pd128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_extractf128_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_insertf128_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x40(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x50(%rsp)
               	leaq	0x50(%rsp), %r9
               	leaq	0x40(%rsp), %rax
               	leaq	0x20(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_permute2f128_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x21, %esi
               	movq	-0x20(%rbp), %rbx
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_permute2f128_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x30, %esi
               	movq	-0x20(%rbp), %rbx
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_permute_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x50(%rsp)
               	movl	0x48(%rsp), %eax
               	movl	0x4c(%rsp), %ecx
               	movl	0x50(%rsp), %edx
               	movl	0x54(%rsp), %esi
               	leaq	0x50(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%ecx, 0x50(%rsp)
               	movl	%eax, 0x54(%rsp)
               	movl	%esi, 0x58(%rsp)
               	movl	%edx, 0x5c(%rsp)
               	movups	0x50(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	movl	0x78(%rsp), %eax
               	movl	0x7c(%rsp), %ecx
               	movl	0x40(%rsp), %edx
               	movl	0x44(%rsp), %esi
               	leaq	0x50(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%ecx, 0x50(%rsp)
               	movl	%eax, 0x54(%rsp)
               	movl	%esi, 0x58(%rsp)
               	movl	%edx, 0x5c(%rsp)
               	leaq	0x40(%rsp), %r9
               	movups	0x50(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x60(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_shuffle_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	movl	0x60(%rsp), %eax
               	movl	0x6c(%rsp), %ecx
               	movl	0x74(%rsp), %edx
               	movl	0x78(%rsp), %esi
               	leaq	0x70(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x70(%rsp)
               	movl	%ecx, 0x74(%rsp)
               	movl	%edx, 0x78(%rsp)
               	movl	%esi, 0x7c(%rsp)
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	movl	0x90(%rsp), %eax
               	movl	0x9c(%rsp), %ecx
               	movl	0x64(%rsp), %edx
               	movl	0x68(%rsp), %esi
               	leaq	0x70(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x70(%rsp)
               	movl	%ecx, 0x74(%rsp)
               	movl	%edx, 0x78(%rsp)
               	movl	%esi, 0x7c(%rsp)
               	leaq	0x60(%rsp), %r9
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_permute_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<_mm256_shuffle_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	movq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_blend_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0xa5, %esi
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	sarxq	%rax, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movl	(%rdx,%rax,4), %edi
               	movl	%edi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blend_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x9, %esi
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	sarxq	%rax, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	movq	%rdi, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blendv_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x40(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movl	(%rsi,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	(%rdx,%rax,4), %edi
               	movl	%edi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_blendv_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x40(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movq	(%rsi,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	movq	%rdi, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_movemask_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	testl	%edx, %edx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	testl	%esi, %esi
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %rbx
               	orq	%rcx, %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	testl	%edx, %edx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	testl	%esi, %esi
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	orq	%rcx, %rax
               	shlq	$0x4, %rax
               	orq	%rbx, %rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_movemask_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	movq	%rax, %rbx
               	orq	%rcx, %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	shlq	$0x2, %rax
               	orq	%rbx, %rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<__badc_cmp_holds>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	ucomisd	%xmm1, %xmm0
               	setp	%al
               	movzbq	%al, %rax
               	ucomisd	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	ucomisd	%xmm1, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	movq	%rdi, %rsi
               	andq	$0x3, %rsi
               	cmpl	$0x1, %esi
               	movl	$0x1, %r8d
               	je	<addr>
               	cmpl	$0x2, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rdi, %r9
               	sarq	$0x4, %r9
               	andq	$0x1, %r9
               	xorq	%r9, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %esi
               	movq	%rdi, %rsi
               	andq	$0xf, %rsi
               	cmpl	$0xf, %esi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rsi,8), %r10
               	jmpq	*%r10
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	leave
               	retq
               	testl	%edx, %edx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movl	$0x1, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	%rax, %rdx
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	testl	%ecx, %ecx
               	jne	<addr>
               	movslq	%edx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rsi, %rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
               	xorl	%edx, %edx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rax
               	leave
               	retq
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%edx, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	leave
               	retq
               	movq	%r8, %rsi
               	jmp	<addr>

<_mm256_cmp_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %rbx
               	movss	(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x20(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x40(%rsp)
               	movss	0x4(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x24(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x44(%rsp)
               	movss	0x8(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x28(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x48(%rsp)
               	movss	0xc(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x2c(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x4c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x30(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x50(%rsp)
               	movss	0x14(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x34(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x54(%rsp)
               	movss	0x18(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x38(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x58(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x3c(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x5c(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cmp_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %rbx
               	movsd	(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x40(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x48(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x50(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x58(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvtepi32_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtdq2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	cvtdq2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvtps_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	cvtps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvttps_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rax
               	leaq	0x70(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	cvttps2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvtps_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	leaq	0x30(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	cvtps2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	movl	0x28(%rsp), %eax
               	movl	0x2c(%rsp), %ecx
               	leaq	0x60(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	%eax, 0x60(%rsp)
               	movl	%ecx, 0x64(%rsp)
               	movl	%eax, 0x68(%rsp)
               	movl	%ecx, 0x6c(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	0x60(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x50(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtps2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvtpd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2ps	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	movl	0x30(%rsp), %eax
               	movl	0x34(%rsp), %ecx
               	movl	0x50(%rsp), %edx
               	movl	0x54(%rsp), %esi
               	leaq	0x70(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x70(%rsp)
               	movl	%ecx, 0x74(%rsp)
               	movl	%edx, 0x78(%rsp)
               	movl	%esi, 0x7c(%rsp)
               	leaq	0x60(%rsp), %rax
               	movups	0x70(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_cvtepi32_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	leaq	0x30(%rsp), %r9
               	movdqu	(%rax), %xmm14
               	cvtdq2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x40(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	pshufd	$0xe, %xmm14, %xmm15    # xmm15 = xmm14[2,3,0,0]
               	movdqu	%xmm15, (%rcx)
               	leaq	0x50(%rsp), %rax
               	movdqu	(%rcx), %xmm14
               	cvtdq2pd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_cvtpd_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvtpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x60(%rsp), %rax
               	leaq	0x30(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_cvttpd_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	movdqu	(%rax), %xmm14
               	cvttpd2dq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	0x60(%rsp), %rax
               	leaq	0x30(%rsp), %rdx
               	movdqu	(%rdx), %xmm15
               	movdqu	(%rcx), %xmm14
               	punpcklqdq	%xmm14, %xmm15  # xmm15 = xmm15[0],xmm14[0]
               	movdqu	%xmm15, (%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_cvtss_f32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movss	(%rsp), %xmm0
               	leave
               	retq

<_mm256_fmadd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	movss	0x40(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	movss	0x44(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	movss	0x48(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x68(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	movss	0x4c(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	movss	0x50(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	movss	0x54(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	movss	0x58(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	movss	0x5c(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmadd_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movsd	(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x68(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x70(%rsp)
               	leaq	0x60(%rsp), %rcx
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x78(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmsub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	movss	0x40(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	movss	0x44(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	movss	0x48(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x68(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	movss	0x4c(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	movss	0x50(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	movss	0x54(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	movss	0x58(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	movss	0x5c(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmsub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movsd	(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x68(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x70(%rsp)
               	leaq	0x60(%rsp), %rcx
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x78(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fnmadd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movss	(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x20(%rsp), %xmm1
               	movss	0x40(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x24(%rsp), %xmm1
               	movss	0x44(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x28(%rsp), %xmm1
               	movss	0x48(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x68(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x2c(%rsp), %xmm1
               	movss	0x4c(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x30(%rsp), %xmm1
               	movss	0x50(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x34(%rsp), %xmm1
               	movss	0x54(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x38(%rsp), %xmm1
               	movss	0x58(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x3c(%rsp), %xmm1
               	movss	0x5c(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fnmadd_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movsd	(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x68(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x70(%rsp)
               	leaq	0x60(%rsp), %rcx
               	movsd	0x18(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x78(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fnmsub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movss	(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x20(%rsp), %xmm1
               	movss	0x40(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x24(%rsp), %xmm1
               	movss	0x44(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x28(%rsp), %xmm1
               	movss	0x48(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x68(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x2c(%rsp), %xmm1
               	movss	0x4c(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x30(%rsp), %xmm1
               	movss	0x50(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x34(%rsp), %xmm1
               	movss	0x54(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x38(%rsp), %xmm1
               	movss	0x58(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x3c(%rsp), %xmm1
               	movss	0x5c(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fnmsub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movsd	(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x8(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x28(%rsp), %xmm1
               	movsd	0x48(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x68(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	0x50(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x70(%rsp)
               	leaq	0x60(%rsp), %rcx
               	movsd	0x18(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x38(%rsp), %xmm1
               	movsd	0x58(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x78(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmaddsub_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	xorl	%eax, %eax
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm1
               	leaq	0x20(%rsp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm2
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmaddsub_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	xorl	%eax, %eax
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rsi
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm1
               	leaq	0x20(%rsp), %rsi
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm2
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmsubadd_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	xorl	%eax, %eax
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm1
               	leaq	0x20(%rsp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_fmsubadd_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	xorl	%eax, %eax
               	leaq	0x60(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rsi
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm1
               	leaq	0x20(%rsp), %rsi
               	addq	%rcx, %rsi
               	movsd	(%rsi), %xmm2
               	testb	$0x1, %al
               	jne	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	jmp	<addr>
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movsd	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<rnd_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xc, %ecx
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%ecx
               	movl	(%rsi,%rdx,4), %eax
               	movl	%eax, -0x10(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7f800000, %rcx       # imm = 0x7F800000
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	orq	$0x400000, %rax         # imm = 0x400000
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	jmp	<addr>
               	movl	$0xb, %ecx
               	jmp	<addr>
               	shrq	$0x10, %rax
               	jmp	<addr>

<rnd_d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xb, %ecx
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%ecx
               	movq	(%rsi,%rdx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	andq	%rax, %rcx
               	movabsq	$0x7ff0000000000000, %r11 # imm = 0x7FF0000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$0xfffffffffffff, %rcx  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movabsq	$0x8000000000000, %r11  # imm = 0x8000000000000
               	orq	%r11, %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rax
               	jmp	<addr>

<fnv>:
               	xorl	%eax, %eax
               	movabsq	$0x100000001b3, %rcx    # imm = 0x100000001B3
               	cmpl	%edx, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %r8
               	xorq	%r8, %rdi
               	imulq	%rcx, %rdi
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<arith>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x4e0, %rsp            # imm = 0x4E0
               	subq	$0x9e0, %rsp            # imm = 0x9E0
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x14b8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x14b8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%edi, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x560(%rsp), %rdx
               	movups	%xmm0, 0x560(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%edi, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x570(%rsp), %rdx
               	movups	%xmm0, 0x570(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1420(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1420(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x580(%rsp), %rdx
               	movups	%xmm0, 0x580(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x590(%rsp), %rdx
               	movups	%xmm0, 0x590(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1388(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1388(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x2, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x2, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x2, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x5a0(%rsp), %rdx
               	movups	%xmm0, 0x5a0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x2, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x5b0(%rsp), %rdx
               	movups	%xmm0, 0x5b0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x12f0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x12f0(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x3, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0xe0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x3, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x3, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x5c0(%rsp), %rdx
               	movups	%xmm0, 0x5c0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x3, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x5d0(%rsp), %rdx
               	movups	%xmm0, 0x5d0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1258(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1258(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x4, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x4, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x4, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x5e0(%rsp), %rdx
               	movups	%xmm0, 0x5e0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x4, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x5f0(%rsp), %rdx
               	movups	%xmm0, 0x5f0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x11c0(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x11c0(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x120(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x5, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x600(%rsp), %rdx
               	movups	%xmm0, 0x600(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x5, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x610(%rsp), %rdx
               	movups	%xmm0, 0x610(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1128(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x1128(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x140(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x6, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x620(%rsp), %rsi
               	movups	%xmm0, 0x620(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x6, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x630(%rsp), %rsi
               	movups	%xmm0, 0x630(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1090(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1090(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x7, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x7, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x7, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x640(%rsp), %rsi
               	movups	%xmm0, 0x640(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x7, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x650(%rsp), %rsi
               	movups	%xmm0, 0x650(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xff8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xff8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x8, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x8, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x8, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x660(%rsp), %rsi
               	movups	%xmm0, 0x660(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x8, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x670(%rsp), %rsi
               	movups	%xmm0, 0x670(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xf60(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xf60(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x1a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x9, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x680(%rsp), %rsi
               	movups	%xmm0, 0x680(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x9, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x690(%rsp), %rsi
               	movups	%xmm0, 0x690(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xec8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xec8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xa, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x1c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xa, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xa, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x6a0(%rsp), %rsi
               	movups	%xmm0, 0x6a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xa, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x6b0(%rsp), %rsi
               	movups	%xmm0, 0x6b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xe30(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xe30(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xb, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x1e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xb, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xb, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x6c0(%rsp), %rsi
               	movups	%xmm0, 0x6c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xb, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x6d0(%rsp), %rsi
               	movups	%xmm0, 0x6d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xd98(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd98(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xc, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x200(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xc, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xc, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x6e0(%rsp), %rsi
               	movups	%xmm0, 0x6e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xc, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x6f0(%rsp), %rsi
               	movups	%xmm0, 0x6f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xd00(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xd00(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xd, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x220(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xd, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xd, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x700(%rsp), %rsi
               	movups	%xmm0, 0x700(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xd, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x710(%rsp), %rsi
               	movups	%xmm0, 0x710(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xc68(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xc68(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xe, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x240(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xe, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xe, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x720(%rsp), %rsi
               	movups	%xmm0, 0x720(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xe, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x730(%rsp), %rsi
               	movups	%xmm0, 0x730(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xbd0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xbd0(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xf, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0xf, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xf, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x740(%rsp), %rsi
               	movups	%xmm0, 0x740(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xf, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x750(%rsp), %rsi
               	movups	%xmm0, 0x750(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xb38(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xb38(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x10, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x280(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x10, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x10, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x760(%rsp), %rsi
               	movups	%xmm0, 0x760(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x10, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x770(%rsp), %rsi
               	movups	%xmm0, 0x770(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xaa0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xaa0(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x11, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x2a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x11, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x11, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x780(%rsp), %rsi
               	movups	%xmm0, 0x780(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x11, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x790(%rsp), %rsi
               	movups	%xmm0, 0x790(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0xa08(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0xa08(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x2c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x12, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x7a0(%rsp), %rsi
               	movups	%xmm0, 0x7a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x12, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x7b0(%rsp), %rsi
               	movups	%xmm0, 0x7b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x970(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x970(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x13, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x2e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x13, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x13, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x7c0(%rsp), %rsi
               	movups	%xmm0, 0x7c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x13, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x7d0(%rsp), %rsi
               	movups	%xmm0, 0x7d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8d8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x8d8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x14, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x300(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x14, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x14, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x7e0(%rsp), %rsi
               	movups	%xmm0, 0x7e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x14, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x7f0(%rsp), %rsi
               	movups	%xmm0, 0x7f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x840(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x840(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x15, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x320(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x15, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x15, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x800(%rsp), %rsi
               	movups	%xmm0, 0x800(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x15, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x810(%rsp), %rsi
               	movups	%xmm0, 0x810(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x7a8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x7a8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x16, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x340(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x16, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x16, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x820(%rsp), %rsi
               	movups	%xmm0, 0x820(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x16, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x830(%rsp), %rsi
               	movups	%xmm0, 0x830(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x710(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x710(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x17, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x360(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x17, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x17, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x840(%rsp), %rsi
               	movups	%xmm0, 0x840(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x17, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x850(%rsp), %rsi
               	movups	%xmm0, 0x850(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x678(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x678(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x18, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x380(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x18, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x18, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x860(%rsp), %rsi
               	movups	%xmm0, 0x860(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x18, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x870(%rsp), %rsi
               	movups	%xmm0, 0x870(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x5e0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x5e0(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x19, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x3a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x19, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x19, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x880(%rsp), %rsi
               	movups	%xmm0, 0x880(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x19, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x890(%rsp), %rsi
               	movups	%xmm0, 0x890(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x548(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x548(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1a, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x3c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1a, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1a, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x8a0(%rsp), %rsi
               	movups	%xmm0, 0x8a0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1a, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x8b0(%rsp), %rsi
               	movups	%xmm0, 0x8b0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x4b0(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x4b0(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1b, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x3e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1b, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1b, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x8c0(%rsp), %rsi
               	movups	%xmm0, 0x8c0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1b, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x8d0(%rsp), %rsi
               	movups	%xmm0, 0x8d0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x418(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x418(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x400(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1c, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x8e0(%rsp), %rsi
               	movups	%xmm0, 0x8e0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1c, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x8f0(%rsp), %rsi
               	movups	%xmm0, 0x8f0(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x380(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x380(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1d, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x420(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1d, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1d, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x900(%rsp), %rsi
               	movups	%xmm0, 0x900(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1d, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x910(%rsp), %rsi
               	movups	%xmm0, 0x910(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x2e8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x2e8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1e, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x440(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1e, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1e, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x920(%rsp), %rsi
               	movups	%xmm0, 0x920(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1e, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x930(%rsp), %rsi
               	movups	%xmm0, 0x930(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x250(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1f, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x460(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x1f, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x990(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9a0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1f, %edi
               	leaq	0x9b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x990(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	0x9a0(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	callq	<addr>
               	negq	%rax
               	movl	%eax, 0x9b0(%rsp)
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x940(%rsp), %rsi
               	movups	%xmm0, 0x940(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rcx
               	leaq	0x9c0(%rsp), %rax
               	leaq	0x80(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x1f, %edi
               	leaq	0x980(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x9c0(%rsp), %xmm0
               	movsd	0x9d0(%rsp), %xmm1
               	callq	<addr>
               	movslq	%eax, %rax
               	negq	%rax
               	movq	%rax, 0x980(%rsp)
               	movups	0x980(%rsp), %xmm0
               	leaq	0x950(%rsp), %rsi
               	movups	%xmm0, 0x950(%rsp)
               	movl	$0x10, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x1b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x480(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %r9
               	leaq	0x80(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x4a0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x960(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %r9
               	leaq	0x4c0(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x970(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x980(%rsp)
               	leaq	0x980(%rsp), %r9
               	leaq	0x80(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x4c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x20, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x4e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x9c, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x6, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1b, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	movl	$0x5, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x21, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x30, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0xa5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %r9
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x500(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %r9
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x520(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movl	%eax, -0x14b8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14b8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x540(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x4c0(%rsp)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	<rip>, %rdi # <addr>
               	movl	$0x10, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %r9
               	movl	$0x1, %esi
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	-0x14d0(%rbp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4c0(%rsp), %rdi
               	leaq	-0x14d0(%rbp), %rax
               	leaq	0xc(%rax), %rsi
               	callq	<addr>
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	-0x14d0(%rbp), %rax
               	movq	-0x14c8(%rbp), %rcx
               	movq	-0x14c0(%rbp), %rdx
               	movq	-0x14b8(%rbp), %rdi
               	leaq	0x4c0(%rsp), %rsi
               	movq	%rax, 0x4c0(%rsp)
               	movq	%rcx, 0x4c8(%rsp)
               	movq	%rdx, 0x4d0(%rsp)
               	movq	%rdi, 0x4d8(%rsp)
               	movl	$0x20, %edx
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movss	%xmm0, -0x14d8(%rbp)
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x14d8(%rbp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leave
               	retq

<fused>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0xa0(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0xa8(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0xb0(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0xb8(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xc0(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0xc8(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x130(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x80(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x100(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	leaq	0x120(%rsp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x170(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x160(%rsp), %xmm0
               	movss	0x170(%rsp), %xmm1
               	movss	0xc0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe0(%rsp)
               	movss	0x164(%rsp), %xmm0
               	movss	0x174(%rsp), %xmm1
               	movss	0xc4(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe4(%rsp)
               	movss	0x168(%rsp), %xmm0
               	movss	0x178(%rsp), %xmm1
               	movss	0xc8(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe8(%rsp)
               	movss	0x16c(%rsp), %xmm0
               	movss	0x17c(%rsp), %xmm1
               	movss	0xcc(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xec(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x100(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	leaq	0x120(%rsp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x170(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x160(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x170(%rsp), %xmm1
               	movss	0xc0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe0(%rsp)
               	movss	0x164(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x174(%rsp), %xmm1
               	movss	0xc4(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe4(%rsp)
               	movss	0x168(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x178(%rsp), %xmm1
               	movss	0xc8(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xe8(%rsp)
               	movss	0x16c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x17c(%rsp), %xmm1
               	movss	0xcc(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0xec(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x100(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	leaq	0x120(%rsp), %rdx
               	leaq	0x170(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x170(%rsp), %xmm0
               	movss	0xc0(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x170(%rsp)
               	movups	0x170(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x100(%rsp), %rax
               	leaq	0x110(%rsp), %rcx
               	leaq	0x120(%rsp), %rdx
               	leaq	0x170(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x170(%rsp), %xmm0
               	movss	0xc0(%rsp), %xmm1
               	movss	0xe0(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213ss	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movss	%xmm0, 0x170(%rsp)
               	movups	0x170(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x60(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x130(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	leaq	0x150(%rsp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x170(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x160(%rsp), %xmm0
               	movsd	0x170(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0xe0(%rsp)
               	movsd	0x168(%rsp), %xmm0
               	movsd	0x178(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x130(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	leaq	0x150(%rsp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x170(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x160(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x170(%rsp), %xmm1
               	movsd	0xc0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0xe0(%rsp)
               	movsd	0x168(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x178(%rsp), %xmm1
               	movsd	0xc8(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x130(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	leaq	0x150(%rsp), %rdx
               	leaq	0x170(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x170(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xc0(%rsp), %xmm1
               	movsd	0xe0(%rsp), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x170(%rsp)
               	movups	0x170(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x130(%rsp), %rax
               	leaq	0x140(%rsp), %rcx
               	leaq	0x150(%rsp), %rdx
               	leaq	0x170(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	0x170(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0xc0(%rsp), %xmm1
               	movsd	0xe0(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	movsd	%xmm0, 0x170(%rsp)
               	movups	0x170(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdx
               	movups	%xmm0, 0xe0(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	$0x4, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	andq	$0x20, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movl	$0x40a00000, %r8d       # imm = 0x40A00000
               	movl	$0x40c00000, %r9d       # imm = 0x40C00000
               	movl	$0x40e00000, %ebx       # imm = 0x40E00000
               	movl	$0x41000000, %r12d      # imm = 0x41000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rsi, %xmm3
               	movq	%r8, %xmm4
               	movq	%r9, %xmm5
               	movq	%rbx, %xmm6
               	movq	%r12, %xmm7
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rsi, %xmm3
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x110(%rsp), %r9
               	leaq	0x100(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0x130(%rsp), %r9
               	leaq	0x140(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0xe0(%rsp), %rax
               	leaq	0xc0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x20, %rsp
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rax # imm = 0xCBF29CE484222325
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%r12,4), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xc0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xbc(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x9c(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb8(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x98(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb4(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x94(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb0(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x90(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xac(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x8c(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa8(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x88(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa4(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x84(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x38(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x50(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	leaq	(%rsp), %r9
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x20(%rsp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdx
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	subq	$0x80, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	callq	<addr>
               	addq	$0x80, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xc0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x80(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xbc(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x9c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x7c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb8(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x98(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x78(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb4(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x94(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x74(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xb0(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x90(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x70(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xac(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x8c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x6c(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa8(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x88(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x68(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0xa4(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x84(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x64(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x60(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x58(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x38(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x18(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x50(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x30(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x48(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	0x80(%rsp), %r9
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdx
               	leaq	-0x60(%rbp), %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x100(%rsp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x100(%rsp), %rsi
               	leaq	0x120(%rsp), %rdi
               	leaq	-0x20(%rbp), %r8
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x120(%rsp), %rdi
               	subq	$0xc0, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x60(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x68(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x70(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x78(%rsp)
               	movq	%rsi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x80(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x90(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x98(%rsp)
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0xa0(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0xa8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0xb0(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0xb8(%rsp)
               	callq	<addr>
               	addq	$0xc0, %rsp
               	incq	%rbx
               	cmpl	$0x96, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x2df3754bb839cc40, %r11 # imm = 0xD20C8AB447C633C0
               	cmpq	%r11, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x74ccbd3f6dc406f9, %r11 # imm = 0x74CCBD3F6DC406F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1109575788509c5, %r11 # imm = 0x1109575788509C5
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x22e32b377fe2c5f9, %r11 # imm = 0x22E32B377FE2C5F9
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x643ff85c67bfe70e, %r11 # imm = 0x643FF85C67BFE70E
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x1399ba70a23f6f3f, %r11 # imm = 0x1399BA70A23F6F3F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x59fced26f1c647c3, %r11 # imm = 0xA60312D90E39B83D
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	<rip>, %rcx # <addr>
               	movabsq	$-0x65ee5915fc0be271, %r11 # imm = 0x9A11A6EA03F41D8F
               	cmpq	%r11, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
