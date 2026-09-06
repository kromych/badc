
posix_timers_and_conversion.x64:	file format elf64-x86-64

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

<doubled>:
               	leaq	(%rdi,%rdi), %rax
               	movslq	%eax, %rax
               	retq

<declared_only>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x190, %rsp            # imm = 0x190
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x29, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x170(%rbp)
               	leaq	-0x170(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	-0x170(%rbp), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x168(%rbp), %rdi
               	movl	$0x7a, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x168(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x160(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x160(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x160(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x7c, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpq	$-0x1, %rbx
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x128(%rbp), %rax
               	movl	$0x68, %ecx
               	movb	%cl, (%rax)
               	movl	$0x69, %ecx
               	movb	%cl, 0x1(%rax)
               	movq	%rax, -0x118(%rbp)
               	leaq	-0x120(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x108(%rbp)
               	movl	$0x8, %eax
               	movq	%rax, -0x100(%rbp)
               	leaq	-0x118(%rbp), %rsi
               	leaq	-0x108(%rbp), %rdx
               	leaq	-0x110(%rbp), %rcx
               	leaq	-0x100(%rbp), %r8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	-0x108(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x100(%rbp), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x120(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xf8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xf8(%rbp), %rsi
               	movl	$0x1, %edi
               	movl	%edi, 0xc(%rsi)
               	leaq	-0xb8(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movl	$0xe10, %eax            # imm = 0xE10
               	movq	%rax, 0x10(%rdx)
               	movq	%rsi, 0x18(%rdx)
               	movq	-0xb8(%rbp), %rdi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0xb8(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	jle	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0xe10, %rax            # imm = 0xE10
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	-0xb8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	-0xb8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	0x20(%rax), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x68(%rax), %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jl	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xfa, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpq	$-0x1, %rbx
               	je	<addr>
               	movl	$0xf9, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rax, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
