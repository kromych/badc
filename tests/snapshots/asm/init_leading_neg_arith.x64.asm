
init_leading_neg_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpq	$-0x4650, %rcx          # imm = 0xB9B0
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpq	$-0x5460, %rcx          # imm = 0xABA0
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x28(%rax), %rcx
               	cmpq	$-0x6234, %rcx          # imm = 0x9DCC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x38(%rax), %rax
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
