
c99_qualifiers.x64:	file format elf64-x86-64

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
               	movl	$0x7, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	-0x8(%rbp), %rax
               	addq	%rax, %rcx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jb	<addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
