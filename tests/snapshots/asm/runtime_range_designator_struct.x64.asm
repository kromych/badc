
runtime_range_designator_struct.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x58, %rsp
               	movl	$0x0, <rip> # <addr>
               	leaq	0x10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0xd, 0x10(%rsp)
               	movq	$0x9, 0x18(%rsp)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x5, 0x40(%rsp)
               	movq	$0x6, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	0x30(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movabsq	$0x50000001d, %rax      # imm = 0x50000001D
               	movq	%rax, 0x30(%rsp)
               	movq	0x30(%rsp), %rax
               	movq	%rax, 0x38(%rsp)
               	movq	%rax, 0x40(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6a, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	cmpl	$0x1d, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	nopl	(%rax,%rax)
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x0, 0x48(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x4c(%rsp)
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	leaq	0x10(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movl	(%rcx), %edx
               	cmpl	$0xd, %edx
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	nopw	%cs:(%rax,%rax)
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	0x40(%rsp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0xd, 0x10(%rsp)
               	movq	$0x9, 0x18(%rsp)
               	leaq	0x20(%rax), %rdx
               	leaq	0x10(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	addq	$0x30, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, 0x40(%rsp)
               	movq	$0x6, 0x48(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	jmp	<addr>
               	leaq	(%rsp), %rdx
               	cmpl	$0x0, (%rsp)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	nop
               	cmpl	$0xd, %esi
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movl	0x40(%rsp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0xd, 0x20(%rsp)
               	movq	$0x1, 0x28(%rsp)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x11, 0x30(%rsp)
               	movq	$0x2, 0x38(%rsp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x68, %eax
               	jmp	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x40(%rsp), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
