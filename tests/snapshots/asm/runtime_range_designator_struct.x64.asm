
runtime_range_designator_struct.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	leaq	-0x90(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, -0x90(%rbp)
               	movq	$0x9, -0x88(%rbp)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x5, -0x60(%rbp)
               	movq	$0x6, -0x58(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	(%rcx), %edx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x69, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	%eax, (%rcx)
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movl	(%rcx), %eax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movl	$0x1d, -0x70(%rbp)
               	movl	$0x5, -0x6c(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6a, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	cmpl	$0x1d, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x58(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x54(%rbp)
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	movl	(%rcx), %edx
               	cmpl	$0xd, %edx
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x60(%rbp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, -0x40(%rbp)
               	movq	$0x9, -0x38(%rbp)
               	leaq	0x20(%rax), %rdx
               	leaq	0x10(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	addq	$0x30, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, -0x10(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdx
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	cmpq	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	cmpl	$0xd, %esi
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xd, -0x30(%rbp)
               	movq	$0x1, -0x28(%rbp)
               	leaq	0x10(%rax), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rax), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	(%rcx), %eax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movl	$0x11, -0x20(%rbp)
               	movq	$0x2, -0x18(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x68, %eax
               	jmp	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
