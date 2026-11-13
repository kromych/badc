
flex_2d_member_index.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movq	$0x4, -0x20(%rbp)
               	leaq	0x4(%rax), %rcx
               	movw	$0x100, (%rcx)          # imm = 0x100
               	movw	$0x302, 0x2(%rcx)       # imm = 0x302
               	movw	$0x504, 0x4(%rcx)       # imm = 0x504
               	leaq	0x6(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	addq	$0x6, %rcx
               	movw	$0x1110, (%rdx)         # imm = 0x1110
               	movw	$0x1312, 0x2(%rcx)      # imm = 0x1312
               	movw	$0x1514, 0x4(%rcx)      # imm = 0x1514
               	leaq	0x4(%rax), %rcx
               	leaq	0xc(%rcx), %rdx
               	movw	$0x2120, (%rdx)         # imm = 0x2120
               	movw	$0x2322, 0x2(%rdx)      # imm = 0x2322
               	leaq	0xc(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	movw	$0x2524, 0x4(%rdx)      # imm = 0x2524
               	leaq	0x12(%rcx), %rdx
               	movw	$0x3130, (%rdx)         # imm = 0x3130
               	movw	$0x3332, 0x2(%rdx)      # imm = 0x3332
               	leaq	0x12(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	movw	$0x3534, 0x4(%rdx)      # imm = 0x3534
               	leaq	0x10(%rax), %rdx
               	movb	$-0x55, 0x1(%rdx)
               	addq	$0x16, %rax
               	subq	%rcx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	0x18(%rcx), %rax
               	leaq	-0x20(%rbp), %rdx
               	subq	%rdx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$0x77, 0x4(%rcx)
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x1c(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x14(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movl	$0x0, -0xc(%rbp)
               	movw	%ax, -0x8(%rbp)
               	movl	$0x4d, -0x8(%rbp)
               	leaq	0x2(%rdx), %rsi
               	leaq	0x18(%rdx), %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	sarq	%rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leave
               	retq
