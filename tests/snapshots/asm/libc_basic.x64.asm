
libc_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x88, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x6c, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x88, %rsp
               	retq
               	movsbq	(%rax), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movzbq	(%rsp), %rax
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x3(%rsp), %r8
               	movzbq	0x4(%rsp), %rcx
               	movb	%al, 0x2(%rsp)
               	movb	%dl, 0x3(%rsp)
               	movb	%sil, 0x4(%rsp)
               	movb	%r8b, 0x5(%rsp)
               	movb	%cl, 0x6(%rsp)
               	movsbq	%al, %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x88, %rsp
               	retq
               	movsbq	%cl, %rax
               	cmpl	$0x34, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	leaq	<rip>, %rcx
               	movl	$0x2a, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	movl	$0x63, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x35, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x51, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x7a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x5a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x66, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x88, %rsp
               	retq
               	movq	$-0x5, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
