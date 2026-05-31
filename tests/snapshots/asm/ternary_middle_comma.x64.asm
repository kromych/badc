
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movl	$0x2a, %ebx
               	movslq	%ebx, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x80, %r9
               	jae	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	%ebx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8)
               	movl	$0x1, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	<addr>
               	movl	$0x63, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rdi
               	movslq	%edi, %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	xorq	$0x2a, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%edi, %r14
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r15)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r15)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r15)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r15)
               	popq	%r11
               	movslq	%ebx, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x80, %r15
               	jae	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	%ebx, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	<addr>
               	movl	$0x63, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %r14
               	movslq	%r14d, %r15
               	cmpq	$0x1, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xa0(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%r14d, %r14
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r15
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r15)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r15)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r15)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r15)
               	popq	%r11
               	movslq	%ebx, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x80, %r15
               	jae	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	%ebx, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, -0xa8(%rbp)
               	jmp	<addr>
               	movl	$0x63, %r14d
               	movq	%r14, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r14
               	movslq	%r14d, %r15
               	cmpq	$0x1, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%r14d, %r14
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movl	%r15d, -0x40(%rbp)
               	movl	%r15d, -0x48(%rbp)
               	movl	%r15d, -0x50(%rbp)
               	movslq	%ebx, %rbx
               	cmpq	$0x0, %rbx
               	jle	<addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x40(%rbp)
               	movl	$0x2, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movl	$0x3, %eax
               	movl	%eax, -0x50(%rbp)
               	movslq	-0x40(%rbp), %rbx
               	movslq	-0x48(%rbp), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movslq	-0x50(%rbp), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x40(%rbp), %r15
               	cmpq	$0x1, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %r15
               	movq	%r15, -0xc8(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x50(%rbp), %r15
               	cmpq	$0x3, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%ebx, %rbx
               	movslq	-0x40(%rbp), %r14
               	movslq	-0x48(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movslq	-0x50(%rbp), %r15
               	movq	%r12, %rdi
               	movq	%r15, %r8
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r15
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r15)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r15)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r15)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r15)
               	popq	%r11
               	movl	$0xc8, %r15d
               	movslq	%r15d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x80, %rax
               	jae	<addr>
               	leaq	-0x60(%rbp), %r14
               	movslq	%r15d, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%r14)
               	movl	$0x1, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	movslq	%eax, %r15
               	cmpq	$0x63, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xe0(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x60(%rbp), %r14
               	movzbq	(%r14), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %r12
               	movslq	%eax, %r15
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
