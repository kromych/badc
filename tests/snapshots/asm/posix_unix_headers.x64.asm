
posix_unix_headers.x64:	file format elf64-x86-64

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
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	-0x208(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	addq	%rdx, %rcx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rcx)
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	cmpq	$0x80, %rcx
               	jl	<addr>
               	leaq	-0x208(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x8, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x208(%rbp), %rax
               	movzbq	0x5(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x208(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x208(%rbp), %rax
               	movzbq	0x5(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x9, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x208(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
