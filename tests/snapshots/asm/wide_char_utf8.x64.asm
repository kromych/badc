
wide_char_utf8.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	andq	$0xff, %rax
               	xorq	$0xc3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	andq	$0xff, %rax
               	xorq	$0xa1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xe1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x62, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x48, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x18(%rax), %rcx
               	cmpq	$0x57, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x2c(%rax), %rcx
               	cmpq	$0x21, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x30(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	addb	%al, (%rax)
