
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
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	(%rdx), %rcx
               	addq	%rcx, %rax
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	jb	<addr>
               	movslq	%eax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	leave
               	retq
