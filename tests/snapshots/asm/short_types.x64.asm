
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<as_short>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movslq	%eax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	testq	%rcx, %rcx
               	je	<addr>
               	subq	$0x10000, %rax          # imm = 0x10000
               	movslq	%eax, %rax
               	retq
               	movslq	%eax, %rax
               	retq

<as_ushort>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x10000, %edi          # imm = 0x10000
               	callq	<addr>
               	movswq	%ax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	movl	$0xc8, %ecx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xd8(%rbp), %rax
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, 0x4(%rax)
               	leaq	-0xd8(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xd8(%rbp), %rcx
               	movswq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0xd8(%rbp), %rcx
               	movswq	0x4(%rcx), %rcx
               	leaq	(%rax,%rcx), %rdi
               	callq	<addr>
               	movw	%ax, 0x6(%rbx)
               	leaq	-0xd8(%rbp), %rax
               	movswq	0x6(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	movabsq	$-0x7, %rcx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0xc0de, %ecx           # imm = 0xC0DE
               	movw	%cx, 0x4(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movswq	(%rax), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movswq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
