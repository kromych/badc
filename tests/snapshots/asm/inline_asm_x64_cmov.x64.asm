
inline_asm_x64_cmov.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x14, %eax
               	movl	$0x2a, %ecx
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x2a, %ebx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0xa, %ebx
               	cmpq	%rbx, %rax
               	cmovlq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rsi
               	movl	$0x64, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x2a, %ebx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x63, %ebx
               	cmpq	%rbx, %rax
               	cmovgq	%rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x2a, %rdx
               	jne	<addr>
               	cmpq	$0x2a, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x2a, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
