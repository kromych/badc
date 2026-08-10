
string_memmem.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %r13
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx
               	movl	$0x4, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rdx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	movq	%rbx, %rdi
               	movq	%rsi, %rcx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x8(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x1, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %esi
               	leaq	<rip>, %rdx
               	movl	$0x5, %ecx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%r13), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x3, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%r12), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %esi
               	leaq	<rip>, %rdx
               	xorq	%rcx, %rcx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rdx
               	movq	%rbx, %rdi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
