
typeof_row_bounds.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, (%rsp)
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0xb0000000a, %rax      # imm = 0xB0000000A
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0xd0000000c, %rax      # imm = 0xD0000000C
               	movq	%rax, 0x18(%rsp)
               	movabsq	$0x1500000014, %rax     # imm = 0x1500000014
               	movq	%rax, 0x20(%rsp)
               	movabsq	$0x1700000016, %rax     # imm = 0x1700000016
               	movq	%rax, 0x28(%rsp)
               	movl	0x10(%rsp), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	(%rsp), %rax
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
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
