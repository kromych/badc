
fd_set_macros.x64:	file format elf64-x86-64

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
               	subq	$0xf0, %rsp
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
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
               	movslq	%ecx, %rax
               	cmpq	$0x80, %rax
               	jge	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x80, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movzbq	0x1(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x80(%rbp), %rax
               	movzbq	0xc(%rax), %rcx
               	orq	$0x10, %rcx
               	movb	%cl, 0xc(%rax)
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0xc(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x2, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0x6(%rax), %rax
               	andq	$0x4, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x81, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x81, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movl	$0x19, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0xc(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
