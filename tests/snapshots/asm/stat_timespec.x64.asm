
stat_timespec.x64:	file format elf64-x86-64

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
               	subq	$0xa0, %rsp
               	leaq	<rip>, %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	0x58(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rax), %rcx
               	cmpq	$0x3b9aca00, %rcx       # imm = 0x3B9ACA00
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x18(%rax), %rax
               	andq	$0xf000, %rax           # imm = 0xF000
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
