
libc_basic.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	movl	$0x6c, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movsbq	(%rax), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movzbq	-0x80(%rbp), %rax
               	movzbq	-0x7f(%rbp), %rdx
               	movzbq	-0x7e(%rbp), %rsi
               	movzbq	-0x7d(%rbp), %rdi
               	movzbq	-0x7c(%rbp), %rcx
               	movb	%al, -0x7e(%rbp)
               	movb	%dl, -0x7d(%rbp)
               	movb	%sil, -0x7c(%rbp)
               	movb	%dil, -0x7b(%rbp)
               	movb	%cl, -0x7a(%rbp)
               	movsbq	%al, %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movsbq	%cl, %rax
               	cmpl	$0x34, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	leaq	<rip>, %rcx
               	movl	$0x2a, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	movl	$0x63, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x35, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x51, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x7a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x5a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x66, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	$-0x5, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
