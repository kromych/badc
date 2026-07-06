
bitfield_compound_assignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0x2, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdx
               	andq	$-0xf1, %rdx
               	orq	%rcx, %rdx
               	movw	%dx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdx
               	andq	$-0xff01, %rdx          # imm = 0xFFFF00FF
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x1, %rcx
               	andq	$0x7, %rcx
               	orq	$0x5, %rcx
               	andq	$0x7, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	shlq	$0x1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x1, %rcx
               	andq	$0x7, %rcx
               	orq	$0x2, %rcx
               	andq	$0x7, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	shlq	$0x1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x1, %rcx
               	andq	$0x6, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	shlq	$0x1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x1, %rcx
               	andq	$0x7, %rcx
               	xorq	$0x7, %rcx
               	andq	$0x7, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	shlq	$0x1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	orq	$0xc0, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	orq	$0xc800, %rcx           # imm = 0xC800
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x1, %rcx
               	andq	$0x7, %rcx
               	xorq	$0x7, %rcx
               	andq	$0x7, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf, %rdx
               	shlq	$0x1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	incq	%rcx
               	andq	$0xf, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf1, %rdx
               	shlq	$0x4, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	subq	$0x4, %rcx
               	andq	$0xf, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf1, %rdx
               	shlq	$0x4, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x1, %rcx
               	andq	$0xff, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xff01, %rdx          # imm = 0xFFFF00FF
               	shlq	$0x8, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	xorq	$0x90, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	sarq	$0x2, %rcx
               	andq	$0xf, %rcx
               	movzwq	(%rax), %rdx
               	andq	$-0xf1, %rdx
               	shlq	$0x4, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
