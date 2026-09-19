
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
               	leaq	-0x8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x1, %ecx
               	jae	<addr>
               	movslq	(%rdx), %rcx
               	addq	%rcx, %rax
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
