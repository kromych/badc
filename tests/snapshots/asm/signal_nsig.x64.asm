
signal_nsig.x64:	file format elf64-x86-64

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
               	subq	$0x118, %rsp            # imm = 0x118
               	leaq	(%rsp), %rax
               	leaq	0x108(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x104, %rcx            # imm = 0x104
               	jge	<addr>
               	movl	$0x5, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	xorl	%eax, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
