
self_declared_library_names_resolve.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rdi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
