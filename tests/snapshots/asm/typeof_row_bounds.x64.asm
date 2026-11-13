
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
               	leaq	-0x30(%rbp), %rax
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movq	%rcx, -0x30(%rbp)
               	movabsq	$0x300000002, %rcx      # imm = 0x300000002
               	movq	%rcx, -0x28(%rbp)
               	addq	$0x10, %rax
               	movabsq	$0xb0000000a, %rcx      # imm = 0xB0000000A
               	movq	%rcx, (%rax)
               	movl	$0xc, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movl	$0xd, 0xc(%rcx)
               	addq	$0x20, %rax
               	movabsq	$0x1500000014, %rcx     # imm = 0x1500000014
               	movq	%rcx, (%rax)
               	movabsq	$0x1700000016, %rcx     # imm = 0x1700000016
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	-0x4(%rbp), %ecx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movl	-0x20(%rbp), %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
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
