
struct_field_assign_from_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<grow>:
               	movl	$0x4, %eax
               	movl	%eax, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq

<wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	0x8(%rbx), %r13
               	movq	0x18(%rbx), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0x14(%rbx), %rsi
               	movslq	0x10(%rbx), %rax
               	leaq	0x1(%rax), %rdx
               	movl	$0x10, %r14d
               	movl	$0x7fff, %r15d          # imm = 0x7FFF
               	movq	%r13, %rdi
               	movq	%r12, %r9
               	movq	%r15, %r8
               	movq	%r14, %rcx
               	callq	<addr>
               	movq	%rax, 0x8(%rbx)
               	movq	0x18(%rbx), %rdi
               	leaq	0x24(%rbx), %rsi
               	movslq	0x20(%rbx), %rax
               	leaq	0x1(%rax), %rdx
               	movq	%r14, %rcx
               	movq	%r12, %r9
               	movq	%r15, %r8
               	callq	<addr>
               	movq	%rax, 0x18(%rbx)
               	movq	0x8(%rbx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rbx), %rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x8(%rbx), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rbx), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x14(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x24(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
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
