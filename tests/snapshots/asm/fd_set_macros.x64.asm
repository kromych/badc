
fd_set_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
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
               	addq	$0x1, %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x80, %rax
               	jge	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movslq	%ecx, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x80, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x10, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x2, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x32, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x4, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x81, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addq	$0xc, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	andq	$-0x81, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x80, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
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
               	addq	$0x1, %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x19, %eax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	andq	$0x10, %rax
               	cmpq	$0x0, %rax
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
               	addb	%al, (%rax)
