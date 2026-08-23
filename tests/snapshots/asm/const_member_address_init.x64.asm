
const_member_address_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rcx
               	leaq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x38(%rax), %rdx
               	leaq	0x28(%rax), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x38(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
