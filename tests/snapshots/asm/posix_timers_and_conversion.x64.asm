
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
               	subq	$0x178, %rsp            # imm = 0x178
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x15, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
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
               	movslq	-0x170(%rbp), %rax
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
               	leaq	-0x168(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x160(%rbp), %rdi
               	xorl	%esi, %esi
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
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x160(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x7c, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
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
               	leaq	-0x128(%rbp), %rax
               	movb	$0x68, (%rax)
               	movb	$0x69, 0x1(%rax)
               	movq	%rax, -0x118(%rbp)
               	leaq	-0x120(%rbp), %rax
               	movq	%rax, -0x110(%rbp)
               	movq	$0x2, -0x108(%rbp)
               	movq	$0x8, -0x100(%rbp)
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
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x0, -0x108(%rbp)
               	jne	<addr>
               	movq	-0x100(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x120(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
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
               	leaq	-0xf8(%rbp), %rdi
               	xorl	%esi, %esi
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdx
               	xorl	%esi, %esi
               	movq	%rsi, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movq	$0xe10, 0x10(%rdx)      # imm = 0xE10
               	movq	%rsi, 0x18(%rdx)
               	movq	-0xb8(%rbp), %rdi
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
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
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
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	jle	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0xe10, %rax            # imm = 0xE10
               	jle	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0xb8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0xb8(%rbp), %rdi
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
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	cmpl	$0x0, 0x68(%rax)
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
