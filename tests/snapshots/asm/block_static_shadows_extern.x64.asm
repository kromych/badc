
block_static_shadows_extern.x64:	file format elf64-x86-64

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

<sink>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	shlq	$0x4, %rcx
               	movslq	%eax, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movzbq	(%r8), %r8
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rdi
               	movl	$0x2, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x345, %rax            # imm = 0x345
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x2, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x67, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	callq	*%rax
               	movq	%rax, %r13
               	leaq	<rip>, %rax
               	movl	$0x1, %r12d
               	leaq	0x1(%rax), %rdi
               	movl	$0x2, %esi
               	movq	(%rbx), %rax
               	callq	*%rax
               	leaq	(%r13,%rax), %r14
               	leaq	<rip>, %r13
               	movq	0x8(%r13), %rdi
               	movq	(%rbx), %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%rax, %r14
               	leaq	<rip>, %rdi
               	movq	(%rbx), %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%rax, %r14
               	movq	(%r13), %rdi
               	movq	(%rbx), %rax
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r14, %rax
               	cmpl	$0xb9b, %eax            # imm = 0xB9B
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
