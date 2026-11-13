
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
               	leaq	-0x20(%rbp), %rcx
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movq	$0x4, -0x20(%rbp)
               	movw	$0x100, -0x1c(%rbp)     # imm = 0x100
               	movw	$0x302, -0x1a(%rbp)     # imm = 0x302
               	movw	$0x504, -0x18(%rbp)     # imm = 0x504
               	movw	$0x1110, -0x16(%rbp)    # imm = 0x1110
               	movw	$0x1312, -0x14(%rbp)    # imm = 0x1312
               	movw	$0x1514, -0x12(%rbp)    # imm = 0x1514
               	movw	$0x2120, -0x10(%rbp)    # imm = 0x2120
               	movw	$0x2322, -0xe(%rbp)     # imm = 0x2322
               	movw	$0x2524, -0xc(%rbp)     # imm = 0x2524
               	movw	$0x3130, -0xa(%rbp)     # imm = 0x3130
               	movw	$0x3332, -0x8(%rbp)     # imm = 0x3332
               	movw	$0x3534, -0x6(%rbp)     # imm = 0x3534
               	movb	$-0x55, -0xf(%rbp)
               	leaq	0x4(%rcx), %rax
               	addq	$0x16, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x12, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	0x18(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	subq	%rax, %rcx
               	cmpq	$0x1c, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$0x77, -0x18(%rbp)
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x1c(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x14(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movw	$0x0, -0x8(%rbp)
               	movl	$0x4d, -0x8(%rbp)
               	leaq	0x2(%rax), %rcx
               	addq	$0x18, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
