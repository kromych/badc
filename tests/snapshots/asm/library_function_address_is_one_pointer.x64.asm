
library_function_address_is_one_pointer.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	addq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	addq	%rbx, %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
