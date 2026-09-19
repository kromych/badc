
inline_asm_x64_sym_riprel.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	incq	%gs:<rip>
               	movq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
