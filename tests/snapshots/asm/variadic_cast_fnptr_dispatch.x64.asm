
variadic_cast_fnptr_dispatch.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	leaq	0x10(%rsp), %rdi
               	movb	$0x0, 0x10(%rsp)
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
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
