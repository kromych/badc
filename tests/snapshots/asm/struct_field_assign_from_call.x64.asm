
struct_field_assign_from_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<grow>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x4, %eax
               	movl	%eax, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	0x8(%rbx), %r14
               	movq	0x18(%rbx), %r15
               	movq	%rbx, %rsi
               	addq	$0x14, %rsi
               	movslq	0x10(%rbx), %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	movl	$0x10, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0x30(%rsp)
               	movq	%r14, %rdi
               	movq	%r12, %r9
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %r8
               	callq	<addr>
               	movq	%rax, 0x8(%rbx)
               	movq	0x18(%rbx), %rdi
               	movq	%rbx, %rsi
               	addq	$0x24, %rsi
               	movslq	0x20(%rbx), %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	movq	%r12, %r9
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %r8
               	callq	<addr>
               	movq	%rax, 0x18(%rbx)
               	movq	0x8(%rbx), %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rbx), %rax
               	cmpq	%rax, %r15
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x8(%rbx), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rbx), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	0x14(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	0x24(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
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
               	movq	0x8(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
