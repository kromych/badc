
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
               	subq	$0x240, %rsp            # imm = 0x240
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	cmpq	$0x80, %rcx
               	jge	<addr>
               	movslq	%edx, %rcx
               	addq	%rax, %rcx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rcx)
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x8, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x28, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x28, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x4, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x9, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x230(%rbp), %rax
               	movl	$0x78, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x230(%rbp), %rax
               	movl	$0x79, %ecx
               	movb	%cl, 0x41(%rax)
               	leaq	-0x230(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x78, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x230(%rbp), %rax
               	movsbq	0x41(%rax), %rax
               	cmpq	$0x79, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
