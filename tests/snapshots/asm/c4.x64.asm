
c4.x64:	file format elf64-x86-64

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
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r11
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	movzbq	(%r9), %r9
               	movq	%r9, (%r11)
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	addq	$0x1, %r9
               	movq	%r9, (%r8)
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0xa, %r11
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r9
               	movq	(%r9), %r12
               	leaq	<rip>, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rdi
               	leaq	<rip>, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rdx
               	movq	%rdi, %r15
               	subq	%rdx, %r15
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x28(%rsp), %r11
               	movq	%rax, (%r11)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	%r14, %rax
               	jge	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax
               	leaq	<rip>, %r14
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movq	(%r12), %r12
               	movl	$0x5, %r11d
               	imulq	%r11, %r12
               	movq	%rax, %r15
               	addq	%r12, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%r14), %r14
               	movq	(%r14), %r14
               	cmpq	$0x7, %r14
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%r15), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x30(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xa, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7a, %rbx
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, -0x40(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, -0x38(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x5a, %rbx
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rbx
               	movq	%rbx, -0x40(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	subq	$0x1, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x30, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x90(%rbp)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x70(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	movl	$0x93, %r11d
               	imulq	%r11, %rax
               	leaq	<rip>, %r14
               	movq	(%r14), %r15
               	movq	%r15, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r14)
               	movzbq	(%r15), %r15
               	addq	%r15, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	shlq	$0x6, %r15
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	subq	%rbx, %r12
               	addq	%r12, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %r12
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r15, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x7a, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x70(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %r12
               	movq	%r12, -0x68(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x78(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	-0x68(%rbp), %r12
               	movq	%r12, -0x60(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x5a, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x78(%rbp), %r12
               	movq	%r12, -0x68(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x80(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	-0x60(%rbp), %r12
               	movq	%r12, -0x58(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x39, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %r12
               	movq	%r12, -0x60(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x5f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	(%r15), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r15
               	cmpq	%r15, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x88(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x10, %rax
               	movq	%rbx, (%rax)
               	movq	(%r15), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%rbx, (%rcx)
               	movq	(%r15), %r15
               	xorq	%r14, %r14
               	movl	$0x85, %ebx
               	movq	%rbx, (%r15)
               	movq	%rbx, (%rax)
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	addq	$0x10, %r15
               	movq	(%r15), %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r14
               	subq	%rbx, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	xorq	%r15, %r15
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r15
               	addq	$0x48, %r15
               	movq	%r15, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x39, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	subq	$0x30, %r14
               	movq	%r14, (%rcx)
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x2f, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x80, %r14d
               	movq	%r14, (%rax)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movzbq	(%r14), %r14
               	xorq	$0x78, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xa0(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	cmpq	$0x30, %rbx
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x98(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %r14
               	movl	$0xa, %r11d
               	imulq	%r11, %r14
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rcx)
               	movzbq	(%rax), %rax
               	addq	%rax, %r14
               	subq	$0x30, %r14
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movzbq	(%r14), %r14
               	cmpq	$0x39, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x58, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rax)
               	movzbq	(%rbx), %rbx
               	movq	%rbx, (%r14)
               	movq	%rbx, -0xa8(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rbx
               	shlq	$0x4, %rbx
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	andq	$0xf, %rax
               	addq	%rax, %rbx
               	movq	(%r14), %r14
               	cmpq	$0x41, %r14
               	jl	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x30, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xc0(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x39, %rbx
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rbx
               	movq	%rbx, -0xb8(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x61, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xc8(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rbx
               	movq	%rbx, -0xb0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x66, %rbx
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x41, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xd0(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rbx
               	movq	%rbx, -0xa8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x46, %rbx
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %rbx
               	movq	%rbx, -0xb0(%rbp)
               	jmp	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	addq	%rax, %rbx
               	movq	%rbx, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	cmpq	$0x30, %rbx
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	shlq	$0x3, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r14
               	movq	%r14, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rdi)
               	movzbq	(%r14), %r14
               	addq	%r14, %rax
               	subq	$0x30, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x37, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x2f, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x27, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xf0(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %r14d
               	movq	%r14, (%rax)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe8(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xa, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x22, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xf0(%rbp)
               	jmp	<addr>
               	movq	-0xf0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x3d, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xf8(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rax)
               	movzbq	(%rcx), %rcx
               	movq	%rcx, (%rbx)
               	cmpq	$0x5c, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x22, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	%rbx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf8(%rbp)
               	jmp	<addr>
               	movq	-0xf8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rbx
               	movq	%rbx, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rcx)
               	movzbq	(%rbx), %rbx
               	movq	%rbx, (%rdi)
               	cmpq	$0x6e, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x22, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rbx
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movb	%r15b, (%rbx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x95, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x8e, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movzbq	(%r14), %r14
               	xorq	$0x2b, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x2d, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rbx
               	movl	$0xa2, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %r14
               	movl	$0x9d, %eax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2d, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x21, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	leaq	<rip>, %r14
               	movl	$0xa3, %eax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9e, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x3c, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x96, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x99, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x3c, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x9b, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x97, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movzbq	(%r14), %r14
               	xorq	$0x3d, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7c, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rbx
               	movl	$0x9a, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movzbq	(%r14), %r14
               	xorq	$0x3e, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rbx
               	movl	$0x9c, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x98, %eax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x7c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x26, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	leaq	<rip>, %r14
               	movl	$0x90, %eax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x92, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x26, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x91, %ebx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x94, %r14d
               	movq	%r14, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x93, %eax
               	movq	%rax, (%r14)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa1, %eax
               	movq	%rax, (%rbx)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	leaq	<rip>, %r14
               	movl	$0x9f, %eax
               	movq	%rax, (%r14)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5b, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa4, %eax
               	movq	%rax, (%rbx)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8f, %eax
               	movq	%rax, (%r14)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x138(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x3b, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x138(%rbp)
               	jmp	<addr>
               	movq	-0x138(%rbp), %rbx
               	movq	%rbx, -0x130(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x130(%rbp)
               	jmp	<addr>
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x128(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7d, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x128(%rbp)
               	jmp	<addr>
               	movq	-0x128(%rbp), %rbx
               	movq	%rbx, -0x120(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x120(%rbp)
               	jmp	<addr>
               	movq	-0x120(%rbp), %rax
               	movq	%rax, -0x118(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x29, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x118(%rbp)
               	jmp	<addr>
               	movq	-0x118(%rbp), %rbx
               	movq	%rbx, -0x110(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x110(%rbp)
               	jmp	<addr>
               	movq	-0x110(%rbp), %rax
               	movq	%rax, -0x108(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x2c, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x108(%rbp)
               	jmp	<addr>
               	movq	-0x108(%rbp), %rbx
               	movq	%rbx, -0x100(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x100(%rbp)
               	jmp	<addr>
               	movq	-0x100(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r9
               	movq	(%r9), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x80, %r15
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r15, (%rsi)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r15)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rsi)
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x22, %r14
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	andq	$-0x8, %rax
               	movq	%rax, (%r14)
               	leaq	<rip>, %rsi
               	movl	$0x2, %eax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x85, %r15
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x8a, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x86, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	xorq	%r12, %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x9f, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x2, %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x29, %r12
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, -0x30(%rbp)
               	jmp	<addr>
               	movl	$0x8, %r15d
               	movq	%r15, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %r15
               	movq	%r15, (%r12)
               	leaq	<rip>, %r14
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	%r12, -0x10(%rbp)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x28, %r14
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2c, %r12
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	-0x10(%rbp), %r12
               	addq	$0x28, %r12
               	movq	(%r12), %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r12
               	cmpq	$0x81, %r12
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x3, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x7, %r12d
               	movq	%r12, (%r14)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	leaq	<rip>, %r15
               	movq	%r12, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r15
               	cmpq	$0x84, %r15
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, (%r15)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %r12
               	movq	-0x10(%rbp), %r15
               	addq	$0x20, %r15
               	movq	(%r15), %r15
               	movq	%r15, (%r12)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r12
               	cmpq	$0x83, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movq	-0x10(%rbp), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %r14d
               	movq	%r14, -0x38(%rbp)
               	jmp	<addr>
               	movl	$0x9, %r14d
               	movq	%r14, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x40(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9f, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x86, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x40(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %r14d
               	movq	%r14, -0x48(%rbp)
               	jmp	<addr>
               	xorq	%r14, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %r14
               	movq	%r14, -0x8(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9f, %r14
               	jne	<addr>
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x94, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	subq	$0x2, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %r12d
               	movq	%r12, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x9, %r12d
               	movq	%r12, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	(%r15), %r15
               	cmpq	$0x9, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x2, %rax
               	movq	%rax, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	xorq	%r14, %r14
               	movq	%r14, (%r12)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x11, %r14d
               	movq	%r14, (%rdx)
               	leaq	<rip>, %rax
               	movq	%r15, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%rdx)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movabsq	$-0x1, %rdx
               	movq	%rdx, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xf, %edx
               	movq	%rdx, (%r12)
               	leaq	<rip>, %rax
               	movq	%r15, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x9e, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0xa2, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x60(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movabsq	$-0x1, %r11
               	imulq	%r11, %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movabsq	$-0x1, %r15
               	movq	%r15, (%rax)
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r14, -0x8(%rbp)
               	callq	<addr>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xa, %r12d
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2, %r12
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	(%r12), %r12
               	cmpq	$0x9, %r12
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x9, %r14d
               	movq	%r14, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	<addr>
               	movq	-0x68(%rbp), %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	<addr>
               	movl	$0x1a, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %r12
               	movq	%r12, (%r14)
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, -0x78(%rbp)
               	jmp	<addr>
               	movl	$0xb, %eax
               	movq	%rax, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x78(%rbp), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	%rbx, %r12
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x8e, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x80(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x8f, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	(%r12), %r12
               	cmpq	$0x9, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %r14
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xc, %r12d
               	movq	%r12, -0x88(%rbp)
               	jmp	<addr>
               	movl	$0xb, %r12d
               	movq	%r12, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %r12
               	movq	%r12, (%r15)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x4, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x90, %r15
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r14
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x18, %r12
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x8f, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x5, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x91, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r12), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x91, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x4, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x92, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r14), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x92, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x93, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0xe, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x93, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x94, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xf, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x94, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x95, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x10, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x95, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x97, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x11, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x96, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x97, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x12, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x97, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x13, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x98, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x14, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x99, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x15, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9a, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x16, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9b, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x9d, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x17, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9c, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9d, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x18, %r14d
               	movq	%r14, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9d, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x9f, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	cmpq	$0x2, %r12
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x9e, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x8, %eax
               	movq	%rax, (%r12)
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1b, %eax
               	movq	%rax, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x19, %r15d
               	movq	%r15, (%r14)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9f, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x90(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x9f, %r12
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1a, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x8, %r12d
               	movq	%r12, (%r14)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1c, %r12d
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movq	%r15, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	cmpq	$0x2, %r12
               	jle	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%rdx)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x8, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r15)
               	movl	$0x1b, %eax
               	movq	%rax, (%rdx)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1a, %eax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1a, %r12d
               	movq	%r12, (%r15)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %r12d
               	movq	%r12, (%rax)
               	leaq	<rip>, %r14
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0xa0, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1c, %r12d
               	movq	%r12, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0xa1, %r12
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1d, %r12d
               	movq	%r12, (%rax)
               	leaq	<rip>, %r14
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0xa2, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	(%r12), %r12
               	cmpq	$0xa, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0xa4, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0xa, %r14d
               	movq	%r14, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rax)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x2, %r15
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	(%r14), %r14
               	cmpq	$0x9, %r14
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movl	$0xd, %edx
               	movq	%rdx, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x9, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %r12
               	movq	%r12, (%rax)
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	<addr>
               	movl	$0x1a, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r15
               	movq	%r15, (%r12)
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movl	$0xb, %eax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rax)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x2, %r15
               	jle	<addr>
               	movl	$0x8, %r12d
               	movq	%r12, -0xb8(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %r12
               	movq	%r12, (%rax)
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %r15d
               	movq	%r15, -0xc0(%rbp)
               	jmp	<addr>
               	movl	$0x19, %r15d
               	movq	%r15, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %r15
               	movq	%r15, (%r12)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %r15
               	cmpq	$0x2, %r15
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x8, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1b, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x19, %r15d
               	movq	%r15, (%rax)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	leaq	<rip>, %r15
               	movq	-0x8(%rbp), %r12
               	subq	$0x2, %r12
               	movq	%r12, (%r15)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %r14
               	cmpq	$0x2, %r14
               	jge	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0x89, %r11
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %r12d
               	movq	%r12, (%rax)
               	movq	(%rbx), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rbx)
               	movq	%rdi, -0x10(%rbp)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	addq	$0x18, %rbx
               	movq	%rbx, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, (%r12)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movq	%rdi, -0x10(%rbp)
               	callq	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x28, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x8b, %r15
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x4, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	%r12, -0x10(%rbp)
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%r14)
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x7b, %r12
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x8e, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x8, %r12d
               	movq	%r12, (%rax)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x3b, %rbx
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x3b, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x7d, %r12
               	je	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	movq	%rsi, %r9
               	movq	%r9, 0x20(%rbp)
               	leaq	0x10(%rbp), %r11
               	movq	(%r11), %r9
               	addq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r9
               	addq	$0x8, %r9
               	movq	%r9, (%r8)
               	movq	0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	je	<addr>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r9
               	movzbq	(%r9), %r9
               	xorq	$0x2d, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %r9
               	movq	%r9, -0x98(%rbp)
               	cmpq	$0x0, %r9
               	je	<addr>
               	movq	0x20(%rbp), %r11
               	movq	(%r11), %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x73, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %r9
               	movl	$0x1, %r11d
               	movq	%r11, (%r9)
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r9)
               	jmp	<addr>
               	movq	0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	cmpq	$0x0, %r11
               	je	<addr>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r8
               	movzbq	(%r8), %r8
               	xorq	$0x2d, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %r8
               	movq	%r8, -0xa8(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	0x20(%rbp), %r11
               	movq	(%r11), %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	xorq	$0x64, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, %r11d
               	movq	%r11, (%r8)
               	leaq	0x10(%rbp), %r9
               	movq	(%r9), %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r9)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r8)
               	jmp	<addr>
               	movq	0x10(%rbp), %r11
               	cmpq	$0x1, %r11
               	jge	<addr>
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x20(%rbp), %rbx
               	movq	(%rbx), %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jge	<addr>
               	leaq	<rip>, %r15
               	movq	0x20(%rbp), %r12
               	movq	(%r12), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movl	$0x40000, %r10d         # imm = 0x40000
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %r12
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r12
               	leaq	<rip>, %r15
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r15)
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r12
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r12
               	movq	%r12, %rdi
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	xorq	%r12, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movq	0x38(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movq	0x38(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movq	0x38(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %r15
               	movq	%r15, (%rax)
               	movl	$0x86, %r12d
               	movq	%r12, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x8d, %r12
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x58(%rbp), %r12
               	movq	(%r12), %r15
               	movq	%r15, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%r12)
               	movq	%r15, (%rax)
               	jmp	<addr>
               	movl	$0x1e, %r15d
               	movq	%r15, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x26, %r15
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	addq	$0x18, %r15
               	movl	$0x82, %ecx
               	movq	%rcx, (%r15)
               	movq	(%rax), %rdx
               	addq	$0x20, %rdx
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %rcx
               	movq	%rcx, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%r15)
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r15
               	movl	$0x86, %ecx
               	movq	%rcx, (%r15)
               	callq	<addr>
               	movq	(%r12), %r12
               	leaq	<rip>, %r15
               	leaq	<rip>, %rbx
               	movq	0x38(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%rbx)
               	movq	%rax, (%r15)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	0x38(%rsp), %r15
               	subq	$0x1, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jg	<addr>
               	leaq	<rip>, %rbx
               	movq	-0x58(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	-0x58(%rbp), %rax
               	addq	%rax, %r15
               	xorq	%rax, %rax
               	movb	%al, (%r15)
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x8a, %r14
               	jne	<addr>
               	jmp	<addr>
               	addq	$0x28, %r12
               	movq	(%r12), %r12
               	movq	%r12, -0x30(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x86, %r14
               	jne	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x88, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x7b, %r14
               	jne	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x85, %r14
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movl	$0x80, %r15d
               	movq	%r15, (%rax)
               	movq	(%rbx), %r14
               	addq	$0x20, %r14
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%rbx), %rbx
               	addq	$0x28, %rbx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	movq	%r15, (%rbx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2c, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, -0x58(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x3b, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb8(%rbp)
               	cmpq	$0x0, %r15
               	je	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x9f, %r15
               	jne	<addr>
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x20, %rax
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x28, %rbx
               	jne	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	addq	$0x18, %rbx
               	movl	$0x81, %eax
               	movq	%rax, (%rbx)
               	movq	(%r14), %r14
               	addq	$0x28, %r14
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%r14)
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movl	$0x83, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rbx
               	addq	$0x28, %rbx
               	leaq	<rip>, %r14
               	movq	(%r14), %rcx
               	movq	%rcx, (%rbx)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x86, %r15
               	jne	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x84, %rbx
               	jne	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x30, %rax
               	movq	(%rbx), %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %r15
               	addq	$0x18, %r15
               	movl	$0x84, %r14d
               	movq	%r14, (%r15)
               	movq	(%rbx), %rax
               	addq	$0x38, %rax
               	movq	(%rbx), %r14
               	addq	$0x20, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %r15
               	addq	$0x20, %r15
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%r15)
               	movq	(%rbx), %rax
               	addq	$0x40, %rax
               	movq	(%rbx), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %rbx
               	addq	$0x28, %rbx
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r15)
               	movq	%r14, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r14
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rax)
               	movq	%r15, (%r14)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x8a, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xc0(%rbp)
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x8a, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x6, %ebx
               	movq	%rbx, (%rax)
               	movq	(%r14), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%r14)
               	movq	-0x58(%rbp), %rbx
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	subq	%r14, %rbx
               	movq	%rbx, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x3b, %r15
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x84, %rbx
               	jne	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x30, %rax
               	movq	(%rbx), %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %rcx
               	addq	$0x18, %rcx
               	movl	$0x84, %r14d
               	movq	%r14, (%rcx)
               	movq	(%rbx), %rax
               	addq	$0x38, %rax
               	movq	(%rbx), %r14
               	addq	$0x20, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %rcx
               	addq	$0x20, %rcx
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%rcx)
               	movq	(%rbx), %rax
               	addq	$0x40, %rax
               	movq	(%rbx), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %rbx
               	addq	$0x28, %rbx
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rcx)
               	movq	%r14, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7d, %rbx
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x8, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	addq	$0x18, %rax
               	movq	(%rcx), %rbx
               	addq	$0x30, %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, (%rax)
               	movq	(%rcx), %r14
               	addq	$0x20, %r14
               	movq	(%rcx), %rbx
               	addq	$0x38, %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, (%r14)
               	movq	(%rcx), %rax
               	addq	$0x28, %rax
               	movq	(%rcx), %rcx
               	addq	$0x40, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rbx
               	addq	$0x48, %rbx
               	movq	%rbx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	-0x38(%rbp), %r15
               	movq	0x38(%rsp), %r10
               	addq	%r10, %r15
               	movq	%r15, -0x38(%rbp)
               	movq	%r15, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x26, %r12d
               	movq	%r12, (%r15)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r15)
               	movq	0x10(%rbp), %r12
               	movq	%r12, (%rax)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%r15)
               	movq	0x20(%rbp), %rax
               	movq	%rax, (%r12)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r15)
               	movq	-0x60(%rbp), %r12
               	movq	%r12, (%rax)
               	xorq	%r15, %r15
               	movq	%r15, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r15d
               	cmpq	$0x0, %r15
               	je	<addr>
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	(%r15), %r15
               	movq	%r15, -0x58(%rbp)
               	leaq	-0x50(%rbp), %r14
               	movq	(%r14), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r14)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rbx
               	movq	-0x50(%rbp), %r15
               	leaq	<rip>, %r14
               	movq	-0x58(%rbp), %r12
               	movl	$0x5, %r11d
               	imulq	%r11, %r12
               	addq	%r12, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%r12), %r12
               	shlq	$0x3, %r12
               	addq	%r12, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x3, %rbx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$-0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	-0x30(%rbp), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r14)
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, (%rax)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rbx)
               	movq	(%rax), %rax
               	shlq	$0x3, %rax
               	subq	%rax, %r14
               	movq	%r14, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x7, %r14
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movq	(%r15), %r15
               	shlq	$0x3, %r15
               	addq	%r15, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	-0x40(%rbp), %r15
               	movq	%r15, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	(%r15), %r15
               	movq	%r15, -0x40(%rbp)
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	movq	(%r15), %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x9, %r15
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %r15
               	movzbq	(%r15), %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0xb, %r15
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	(%r15), %r15
               	movq	-0x48(%rbp), %r12
               	movq	%r12, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0xc, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rax
               	movb	%al, (%r12)
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r15)
               	movq	-0x48(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0xe, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	orq	%rbx, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0xf, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	xorq	%r15, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x10, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	andq	%rbx, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x11, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x12, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	cmpq	%rbx, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x13, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x14, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	cmpq	%rbx, %r12
               	setg	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x15, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x16, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	cmpq	%rbx, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x17, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	movq	%r15, %rcx
               	shlq	%cl, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x18, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, %rcx
               	sarq	%cl, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x19, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	addq	%r15, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1a, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	subq	%rbx, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1b, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	imulq	%r15, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1c, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1d, %r12
               	jne	<addr>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r12), %r12
               	movq	-0x48(%rbp), %r15
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1e, %r12
               	jne	<addr>
               	movq	-0x38(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r12
               	movq	(%r15), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r14
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	movq	(%r15), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x20, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %r15
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r15
               	movq	%r15, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %r15
               	addq	$-0x8, %r15
               	movq	(%r15), %r15
               	movq	%rax, %r12
               	addq	$-0x10, %r12
               	movq	(%r12), %r12
               	movq	%rax, %r14
               	addq	$-0x18, %r14
               	movq	(%r14), %r14
               	movq	%rax, %rbx
               	addq	$-0x20, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rax, %rcx
               	addq	$-0x28, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, 0x28(%rsp)
               	addq	$-0x30, %rax
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %r9
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movq	0x30(%rsp), %rcx
               	movq	0x28(%rsp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x24, %rbx
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %rbx
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r14
               	movq	(%rax), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r12
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r14
               	movq	(%r15), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	-0x50(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	-0x58(%rbp), %r14
               	movq	-0x50(%rbp), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	addb	%al, 0x41(%rdx)
