
flex_2d_member_index.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rcx
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movl	$0x0, 0x18(%rsp)
               	movq	$0x4, (%rsp)
               	movw	$0x100, 0x4(%rsp)       # imm = 0x100
               	movw	$0x302, 0x6(%rsp)       # imm = 0x302
               	movw	$0x504, 0x8(%rsp)       # imm = 0x504
               	movw	$0x1110, 0xa(%rsp)      # imm = 0x1110
               	movw	$0x1312, 0xc(%rsp)      # imm = 0x1312
               	movw	$0x1514, 0xe(%rsp)      # imm = 0x1514
               	movw	$0x2120, 0x10(%rsp)     # imm = 0x2120
               	movw	$0x2322, 0x12(%rsp)     # imm = 0x2322
               	movw	$0x2524, 0x14(%rsp)     # imm = 0x2524
               	movw	$0x3130, 0x16(%rsp)     # imm = 0x3130
               	movw	$0x3332, 0x18(%rsp)     # imm = 0x3332
               	movw	$0x3534, 0x1a(%rsp)     # imm = 0x3534
               	movb	$-0x55, 0x11(%rsp)
               	leaq	0x4(%rcx), %rdx
               	leaq	0x16(%rcx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rdx), %rax
               	leaq	(%rsp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, (%rsp)
               	movl	$0x0, 0x4(%rsp)
               	movl	$0x0, 0x8(%rsp)
               	movl	$0x0, 0xc(%rsp)
               	movl	$0x0, 0x10(%rsp)
               	movl	$0x0, 0x14(%rsp)
               	xorl	%eax, %eax
               	movl	$0x4d, 0x18(%rsp)
               	leaq	0x2(%rcx), %rdx
               	addq	$0x18, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	sarq	%rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	addq	$0x28, %rsp
               	retq
