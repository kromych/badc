
zero_length_array_sizeof.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rdi
               	movl	0x4(%rax), %edx
               	cmpq	$0x4, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	%edx, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	movl	0x4(%rax), %r8d
               	andq	$0x7, %r8
               	addq	%rsi, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, (%rdi)
               	movl	0x4(%rax), %edi
               	incq	%rdi
               	movl	%edi, 0x4(%rax)
               	movl	%edx, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	addq	%rdx, %rax
               	movzbq	-0x28(%rbp), %rdx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x42, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x41, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x44, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x43, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
