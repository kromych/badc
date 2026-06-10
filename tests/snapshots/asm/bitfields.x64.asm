
bitfields.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x230, %esi            # imm = 0x230
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	movl	$0x1, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x3, %rcx
               	xorq	%rdx, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1d, %rcx
               	movl	$0x14, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x3e1, %rcx           # imm = 0xFC1F
               	movl	$0x220, %edx            # imm = 0x220
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	movabsq	$-0x100000000, %r13     # imm = 0xFFFFFFFF00000000
               	andq	%r13, %rcx
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	orq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3e7, %ecx            # imm = 0x3E7
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %eax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	xorq	%rdx, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %eax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1d, %rcx
               	movl	$0x1c, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x5, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x2, %rcx
               	movl	$0x1, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x3, %rcx
               	movl	$0x2, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x5, %rcx
               	xorq	%rdx, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x9, %rcx
               	movl	$0x8, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0xf1, %rcx
               	movl	$0xb0, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	movl	$0xc800, %edx           # imm = 0xC800
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x1, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x2, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x3, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0xff01, %rcx          # imm = 0xFFFF00FF
               	leaq	-0x18(%rbp), %rdx
               	movl	(%rdx), %edx
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc9, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
