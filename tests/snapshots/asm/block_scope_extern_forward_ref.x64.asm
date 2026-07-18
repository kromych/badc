
block_scope_extern_forward_ref.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	addq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
