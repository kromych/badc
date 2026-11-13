
stdio_line_input.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x6, %edx
               	movq	0x8(%rsp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	0x8(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x7, %edx
               	movq	0x8(%rsp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	0x8(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x5, %rax
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rax
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	0x8(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rax
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	0x8(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	0x8(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	0x8(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x2, -0x48(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x3a, %edx
               	movq	0x8(%rsp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x7, %rax
               	jae	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rax
               	cmpb	$0x0, 0x6(%rax)
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x3a, %edx
               	movq	0x8(%rsp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	movq	%rdi, (%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rdi
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rdi, (%rsp)
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rsp), %rdi
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x9, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
