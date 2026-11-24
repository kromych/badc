
block_scope_typedef_variadic_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rdi
               	movb	$0x0, (%rsp)
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movl	$0x7, %ecx
               	leaq	<rip>, %r8
               	movq	<rip>, %r9 # <addr>
               	movb	$0x0, %al
               	callq	*%r9
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
