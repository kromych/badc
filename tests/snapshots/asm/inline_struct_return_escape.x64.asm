
inline_struct_return_escape.x64:	file format elf64-x86-64

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

<mkesc>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %ecx
               	movq	%rcx, (%rsi)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rcx, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2a, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
