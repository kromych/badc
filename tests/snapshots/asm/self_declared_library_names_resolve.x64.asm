
self_declared_library_names_resolve.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	leaq	<rip>, %rdi
               	callq	*%rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpq	$0x3, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
