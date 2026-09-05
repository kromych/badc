
addr_of_libc_strcmp.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	<rip>, %rbx      # <addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rax
               	callq	*%rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jl	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jg	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rax
               	callq	*%rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
