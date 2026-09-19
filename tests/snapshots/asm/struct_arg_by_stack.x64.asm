
struct_arg_by_stack.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rbx
               	movq	$0x7, (%rbx)
               	leaq	<rip>, %rax
               	movq	$0xb, (%rax)
               	leaq	<rip>, %rcx
               	movq	$0x16, (%rcx)
               	leaq	<rip>, %rdx
               	movq	$0x21, (%rdx)
               	leaq	<rip>, %rsi
               	movq	$0x2c, (%rsi)
               	leaq	<rip>, %rdi
               	movq	$0x5, (%rdi)
               	leaq	<rip>, %r8
               	movq	$0x6, (%r8)
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rdi), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	(%r8), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
