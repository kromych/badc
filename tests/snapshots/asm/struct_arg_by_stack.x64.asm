
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xb, %eax
               	movl	$0x16, %ecx
               	movl	$0x21, %edx
               	movl	$0x2c, %esi
               	movl	$0x5, %edi
               	movl	$0x6, %r8d
               	movl	$0x7, %r9d
               	leaq	<rip>, %rbx
               	movq	%r9, (%rbx)
               	leaq	<rip>, %r9
               	movq	%rax, (%r9)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rax
               	movq	%r8, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	leave
               	retq
