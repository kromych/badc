
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
               	retq

<declared_only>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x178, %rsp            # imm = 0x178
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rax
               	movl	$0x29, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, -0x170(%rbp)
               	leaq	-0x170(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x170(%rbp), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	movsbq	-0x168(%rbp), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xe8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0xe8(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0xd4(%rbp), %eax
               	cmpl	$0x7c, %eax
               	jne	<addr>
               	movl	-0xd8(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0xdc(%rbp), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x160(%rbp), %rax
               	movb	$0x68, -0x160(%rbp)
               	movb	$0x69, -0x15f(%rbp)
               	movq	%rax, -0x150(%rbp)
               	leaq	-0x158(%rbp), %rax
               	movq	%rax, -0x148(%rbp)
               	movq	$0x2, -0x140(%rbp)
               	movq	$0x8, -0x138(%rbp)
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x140(%rbp), %rdx
               	leaq	-0x148(%rbp), %rcx
               	leaq	-0x138(%rbp), %r8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x0, -0x140(%rbp)
               	jne	<addr>
               	movq	-0x138(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movsbq	-0x158(%rbp), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movsbq	-0x157(%rbp), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	movl	$0x1, %edi
               	movl	%edi, -0xa4(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x128(%rbp), %rdx
               	xorl	%esi, %esi
               	movq	%rsi, -0x128(%rbp)
               	movq	%rsi, -0x120(%rbp)
               	movq	$0xe10, -0x118(%rbp)    # imm = 0xE10
               	movq	%rsi, -0x110(%rbp)
               	movq	-0x130(%rbp), %rdi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x108(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x130(%rbp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0xf8(%rbp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	-0xf8(%rbp), %rax
               	cmpq	$0xe10, %rax            # imm = 0xE10
               	jle	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x130(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x130(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x70(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x0, -0x50(%rbp)
               	je	<addr>
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
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
               	jge	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
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
               	jge	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
