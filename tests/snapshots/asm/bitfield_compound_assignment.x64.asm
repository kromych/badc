
bitfield_compound_assignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	xorq	%rdx, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x1, %rdx
               	andq	$0x7, %rdx
               	orq	$0x5, %rdx
               	andq	$0x7, %rdx
               	shlq	$0x1, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x1, %rdx
               	andq	$0x7, %rdx
               	orq	$0x2, %rdx
               	andq	$0x7, %rdx
               	shlq	$0x1, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x1, %rdx
               	andq	$0x6, %rdx
               	shlq	$0x1, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x1, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x7, %rdx
               	andq	$0x7, %rdx
               	shlq	$0x1, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	movl	$0x1, %edx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	movl	$0xc0, %edx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	movl	$0xc800, %edx           # imm = 0xC800
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x1, %rdx
               	andq	$0x7, %rdx
               	xorq	$0x7, %rdx
               	andq	$0x7, %rdx
               	shlq	$0x1, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	incq	%rdx
               	andq	$0xf, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	subq	$0x4, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x1, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	movl	$0x190, %ecx            # imm = 0x190
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xf1, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movzwq	(%rdx), %rdx
               	sarq	$0x4, %rdx
               	andq	$0xf, %rdx
               	sarq	$0x2, %rdx
               	andq	$0xf, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
