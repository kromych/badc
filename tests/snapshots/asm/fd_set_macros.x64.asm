
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0x88(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x90(%rbp)
               	jmp	<addr>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
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
               	movzbq	(%r8), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	-0x98(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %rax
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
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	orq	$0x1, %r9
               	movb	%r9b, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %eax
               	shlq	$0x7, %rax
               	orq	%rax, %r11
               	movb	%r11b, (%r9)
               	jmp	<addr>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r11
               	movl	$0x8, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	popq	%rdx
               	addq	%rax, %r11
               	movzbq	(%r11), %rax
               	orq	$0x1, %rax
               	movb	%al, (%r11)
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %rax
               	movl	$0x64, %r9d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	movl	$0x1, %r11d
               	shlq	$0x4, %r11
               	orq	%r11, %r9
               	movb	%r9b, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x80(%rbp), %r11
               	xorq	%r9, %r9
               	movl	$0x8, %eax
               	movq	%rax, %r10
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
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x7, %eax
               	movl	$0x8, %r11d
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	addq	%rax, %r9
               	movzbq	(%r9), %rax
               	movl	$0x1, %r9d
               	shlq	$0x7, %r9
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x64, %eax
               	movl	$0x8, %r11d
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	addq	%rax, %r9
               	movzbq	(%r9), %rax
               	movl	$0x1, %r9d
               	shlq	$0x4, %r9
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x1, %r9d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rdi
               	shlq	$0x1, %r9
               	andq	%r9, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x32, %eax
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	addq	%rax, %rdi
               	movzbq	(%rdi), %rax
               	movl	$0x1, %edi
               	shlq	$0x2, %rdi
               	andq	%rdi, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rdi
               	xorq	$0x81, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %r9
               	xorq	$0x1, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addq	$0xc, %rax
               	movzbq	(%rax), %r9
               	xorq	$0x10, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xc8(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movl	$0x7, %r9d
               	movl	$0x8, %edi
               	movq	%rdi, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	movl	$0x1, %edi
               	shlq	$0x7, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %r9
               	movb	%r9b, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x7, %r9d
               	movl	$0x8, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	movl	$0x1, %edi
               	shlq	$0x7, %rdi
               	andq	%rdi, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	xorq	%rax, %rax
               	movl	$0x8, %edi
               	movq	%rdi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	addq	%rax, %r9
               	movzbq	(%r9), %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %rax
               	xorq	%r9, %r9
               	movl	$0x8, %edi
               	movq	%rdi, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rax
               	movzbq	(%rax), %r9
               	orq	$0x1, %r9
               	movb	%r9b, (%rax)
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	xorq	%r9, %r9
               	movl	$0x8, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xd8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0xe0(%rbp)
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	xorq	%rdi, %rdi
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0xe0(%rbp), %rax
               	cmpq	$0x80, %rax
               	jge	<addr>
               	movq	-0xd8(%rbp), %r9
               	movslq	-0xe0(%rbp), %rax
               	addq	%rax, %r9
               	xorq	%rax, %rax
               	movb	%al, (%r9)
               	movslq	-0xe0(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0xe0(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x19, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x64, %eax
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	addq	%rax, %rdi
               	movzbq	(%rdi), %rax
               	movl	$0x1, %edi
               	shlq	$0x4, %rdi
               	andq	%rdi, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1a, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
