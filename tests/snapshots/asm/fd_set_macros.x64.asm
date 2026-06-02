
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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0x88(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x90(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	<addr>
               	movslq	-0x90(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	<addr>
               	movq	-0x88(%rbp), %r11
               	movslq	-0x90(%rbp), %r9
               	addq	%r9, %r11
               	xorq	%r9, %r9
               	movb	%r9b, (%r11)
               	movslq	-0x90(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x90(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x98(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	<addr>
               	leaq	-0x80(%rbp), %r8
               	movslq	-0x98(%rbp), %r9
               	addq	%r9, %r8
               	movzbq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x98(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x98(%rbp)
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %r9
               	xorq	%r8, %r8
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r9
               	movzbq	(%r9), %r8
               	orq	$0x1, %r8
               	movb	%r8b, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r8
               	movl	$0x7, %r11d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r8
               	movzbq	(%r8), %r11
               	orq	$0x80, %r11
               	movb	%r11b, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r11
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	orq	$0x1, %r9
               	movb	%r9b, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %r9
               	movl	$0x64, %r8d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r9
               	movzbq	(%r9), %r8
               	orq	$0x10, %r8
               	movb	%r8b, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	xorq	%r8, %r8
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x7, %r8d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x80, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x64, %r8d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x10, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x1, %r8d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x2, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x32, %r8d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r11
               	andq	$0x4, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movzbq	(%r11), %r8
               	xorq	$0x81, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x1, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	addq	$0xc, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x10, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xd, %r8d
               	movq	%r8, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xc8(%rbp)
               	movq	-0xc8(%rbp), %r8
               	movl	$0x7, %r11d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r8
               	movzbq	(%r8), %r11
               	andq	$-0x81, %r11
               	movb	%r11b, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r9
               	andq	$0x80, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	xorq	%r11, %r11
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x8, %r11d
               	movq	%r11, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %r11
               	xorq	%r9, %r9
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	orq	$0x1, %r9
               	movb	%r9b, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	xorq	%r9, %r9
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r8
               	movzbq	(%r8), %r8
               	andq	$0x1, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xd8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0xe0(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	xorq	%r11, %r11
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	jmp	<addr>
               	movslq	-0xe0(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	<addr>
               	movq	-0xd8(%rbp), %r8
               	movslq	-0xe0(%rbp), %r9
               	addq	%r9, %r8
               	xorq	%r9, %r9
               	movb	%r9b, (%r8)
               	movslq	-0xe0(%rbp), %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0xe0(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x19, %r11d
               	movq	%r11, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x64, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r9
               	andq	$0x10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1a, %r11d
               	movq	%r11, %rax
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
               	addb	%al, 0x41(%rdx)
