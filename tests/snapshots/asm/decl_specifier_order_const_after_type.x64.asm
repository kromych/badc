
decl_specifier_order_const_after_type.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movb	%al, (%rcx)
               	leaq	<rip>, %rcx
               	movb	%al, (%rcx)
               	leaq	<rip>, %rcx
               	movb	%al, (%rcx)
               	leaq	<rip>, %rcx
               	movb	%al, (%rcx)
               	leaq	<rip>, %rcx
               	movb	%al, (%rcx)
               	xorq	%rax, %rax
               	retq
