
zero_fill_narrow_member_guard.x64:	file format elf64-x86-64

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

<reader>:
               	xorq	%rax, %rax
               	movl	$0x2, %ecx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r8d
               	movq	%rax, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %r9
               	incq	%r9
               	movl	%r9d, (%rdi)
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x2, %edx
               	jb	<addr>
               	movl	(%rsi), %ecx
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	(%rsi), %ecx
               	movl	%r8d, %edx
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	%edi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %r12
               	movl	$0x2, %eax
               	movl	%eax, (%r12)
               	leaq	<rip>, %r13
               	movl	$0x7, %eax
               	movl	%eax, (%r13)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	%eax, (%r12)
               	movl	$0x9, %eax
               	movl	%eax, (%r13)
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
