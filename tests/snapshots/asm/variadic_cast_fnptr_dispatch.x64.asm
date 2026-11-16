
variadic_cast_fnptr_dispatch.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rdi
               	movb	$0x0, -0x20(%rbp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x8(%rsp)
               	movl	$0x20, %esi
               	leaq	<rip>, %rdx
               	movl	$0x4, %ecx
               	leaq	<rip>, %r8
               	movl	$0x9, %r9d
               	movq	0x8(%rsp), %r10
               	movb	$0x0, %al
               	callq	*%r10
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
