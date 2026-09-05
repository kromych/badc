
compound_literal_struct_array.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x9, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	0x8(%rcx), %rcx
               	cmpl	$0x78, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	0x14(%rax), %rax
               	cmpl	$0x79, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rdi
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdi), %rcx
               	movq	%rcx, 0x18(%rax)
               	popq	%rcx
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdi)
               	popq	%rax
               	leaq	-0x48(%rbp), %r8
               	leaq	<rip>, %r12
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r12), %rax
               	movq	%rax, 0x8(%r8)
               	movq	0x10(%r12), %rax
               	movq	%rax, 0x10(%r8)
               	popq	%rax
               	leaq	-0x50(%rbp), %r8
               	leaq	<rip>, %r14
               	pushq	%rax
               	movq	(%r14), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r14), %rax
               	movq	%rax, 0x8(%r8)
               	movq	0x10(%r14), %rax
               	movq	%rax, 0x10(%r8)
               	movq	0x18(%r14), %rax
               	movq	%rax, 0x18(%r8)
               	popq	%rax
               	xorq	%r13, %r13
               	xorq	%r13, %r13
               	xorq	%r13, %r13
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %r9
               	xorq	%rcx, %rcx
               	movq	%rcx, %r9
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movl	$0x3, %edx
               	leaq	-0x30(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	%edx, (%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x5, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x6, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x30(%rbp), %r8
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdi
               	imulq	$0xa, %rdi, %rdi
               	movslq	0x4(%rdx), %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	leaq	-0x18(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r8)
               	popq	%rcx
               	movq	%r8, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdi
               	imulq	$0xa, %rdi, %rdi
               	movslq	0x4(%rdx), %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	movq	0x10(%rsp), %r14
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
