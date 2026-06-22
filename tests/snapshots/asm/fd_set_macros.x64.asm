
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
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%r13, (%rsp)
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
               	movslq	%edx, %rcx
               	incq	%rcx
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
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	%ecx, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x80, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x10, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x1, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x2, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x32, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x4, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x81, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movzbq	0xc(%rax), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x81, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
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
               	movslq	%edx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x19, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	xorq	%rdx, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
