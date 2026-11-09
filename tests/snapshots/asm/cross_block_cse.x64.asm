
cross_block_cse.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x0, -0x28(%rbp)
               	movl	$0x1, -0x24(%rbp)
               	movl	$0x4, -0x20(%rbp)
               	movl	$0x9, -0x1c(%rbp)
               	movl	$0x10, -0x18(%rbp)
               	movl	$0x19, -0x14(%rbp)
               	movl	$0x24, -0x10(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x31, -0xc(%rbp)
               	movl	$0x40, -0x8(%rbp)
               	movl	$0x51, -0x4(%rbp)
               	movl	-0xc(%rbp), %eax
               	cmpl	$0xc8, %eax
               	jle	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0x31, %eax
               	jne	<addr>
               	movl	$0x99, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0x23, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0xf423f, %ecx          # imm = 0xF423F
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x43e0000000000000, %rax # imm = 0x43E0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x5f000000, %eax       # imm = 0x5F000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	(%rax,%rax,2), %rsi
               	incq	%rsi
               	movq	(%rdx,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jle	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rcx
               	jmp	<addr>
               	subq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
