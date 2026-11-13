
typeof_row_bounds.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, -0x30(%rbp)
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xb0000000a, %rax      # imm = 0xB0000000A
               	movq	%rax, -0x20(%rbp)
               	movabsq	$0xd0000000c, %rax      # imm = 0xD0000000C
               	movq	%rax, -0x18(%rbp)
               	movabsq	$0x1500000014, %rax     # imm = 0x1500000014
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x1700000016, %rax     # imm = 0x1700000016
               	movq	%rax, -0x8(%rbp)
               	movl	-0x20(%rbp), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
