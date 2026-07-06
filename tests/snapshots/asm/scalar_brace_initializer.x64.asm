
scalar_brace_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x5, %eax
               	leaq	<rip>, %rcx
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	movl	$0x7, %esi
               	leaq	(%rax,%rdx), %rdi
               	movslq	%edi, %rdi
               	cmpq	$0xb, %rdi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x29, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsbq	(%rcx), %rax
               	cmpq	$0x78, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r8d
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x1(%rcx), %rax
               	cmpq	$0x79, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movsbq	0x2(%rcx), %rax
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpq	$0x7, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
