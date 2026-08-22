
struct_field_assign_from_call.x64:	file format elf64-x86-64

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

<wrap>:
               	movq	0x8(%rdi), %rcx
               	movq	0x18(%rdi), %r8
               	movl	$0x4, %edx
               	movl	%edx, 0x14(%rdi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	movq	%rax, 0x8(%rdi)
               	movl	%edx, 0x24(%rdi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	movq	%rax, 0x18(%rdi)
               	movq	0x8(%rdi), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x18(%rdi), %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rdi), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x18(%rdi), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x14(%rdi), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x24(%rdi), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movq	0x8(%rbx), %rdx
               	movq	0x18(%rbx), %rcx
               	movslq	0x14(%rbx), %r8
               	movslq	0x24(%rbx), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
