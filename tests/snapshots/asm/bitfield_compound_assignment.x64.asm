
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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rax, %rax
               	movzwq	(%rcx), %rdx
               	andq	$-0x2, %rdx
               	orq	%rax, %rdx
               	movw	%dx, (%rcx)
               	leaq	-0x8(%rbp), %rsi
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xf, %rcx
               	orq	%rax, %rcx
               	movw	%cx, (%rsi)
               	leaq	-0x8(%rbp), %rdx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xf1, %rcx
               	orq	%rax, %rcx
               	movw	%cx, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	orq	%rcx, %rax
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	%rdx
               	andq	$0x7, %rdx
               	orq	$0x5, %rdx
               	andq	$0x7, %rdx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	orq	$0xe, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	%rdx
               	andq	$0x6, %rdx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	orq	$0x2, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movw	%ax, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	$0xc0, %rax
               	movw	%ax, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	orq	$0xc800, %rax           # imm = 0xC800
               	movw	%ax, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	%rdx
               	andq	$0x7, %rdx
               	xorq	$0x7, %rdx
               	andq	$0x7, %rdx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf, %rax
               	shlq	%rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	%rcx
               	andq	$0x7, %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	cmpq	$0xc8, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	$0xd0, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	orq	$0x90, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	%rdx
               	andq	$0xff, %rdx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	shlq	$0x8, %rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	xorq	$0x90, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	sarq	$0x2, %rdx
               	andq	$0xf, %rdx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xf1, %rax
               	shlq	$0x4, %rdx
               	orq	%rdx, %rax
               	movw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
