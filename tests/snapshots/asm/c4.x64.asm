
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
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r9
               	movq	(%r9), %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %r11
               	leaq	<rip>, %r12
               	movq	(%r12), %rdx
               	movq	%r11, %rcx
               	subq	%rdx, %rcx
               	movq	(%r12), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	movq	%r10, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rbx
               	movq	%rbx, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	(%r14), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r14)
               	movq	(%rdx), %rdx
               	movl	$0x5, %r11d
               	imulq	%r11, %rdx
               	movq	%rbx, %rsi
               	addq	%rdx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%r14), %r14
               	movq	(%r14), %r14
               	cmpq	$0x7, %r14
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r14
               	movq	(%r14), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
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
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x30(%rbp)
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rsi)
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x7a, %rdi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rdi
               	movq	%rdi, -0x40(%rbp)
               	cmpq	$0x0, %rdi
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
               	movq	-0x40(%rbp), %rdi
               	movq	%rdi, -0x38(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x5a, %rdi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rdi
               	movq	%rdi, -0x40(%rbp)
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %r12
               	subq	$0x1, %r12
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x30, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x90(%rbp)
               	cmpq	$0x0, %rsi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x61, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x70(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	movl	$0x93, %r11d
               	imulq	%r11, %rdi
               	leaq	<rip>, %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %rcx
               	addq	$0x1, %rcx
               	movq	%rcx, (%r14)
               	movzbq	(%rbx), %rbx
               	addq	%rbx, %rdi
               	movq	%rdi, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rbx
               	shlq	$0x6, %rbx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	subq	%r12, %rsi
               	addq	%rsi, %rbx
               	movq	%rbx, (%rdi)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x7a, %rsi
               	setle	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x70(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rsi
               	movq	%rsi, -0x68(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x41, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x78(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0x68(%rbp), %rsi
               	movq	%rsi, -0x60(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x5a, %rsi
               	setle	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x78(%rbp), %rsi
               	movq	%rsi, -0x68(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x30, %rdi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x80(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0x60(%rbp), %rsi
               	movq	%rsi, -0x58(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x39, %rsi
               	setle	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rsi
               	movq	%rsi, -0x60(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x5f, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rbx
               	cmpq	%rbx, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x88(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x10, %rax
               	movq	%r12, (%rax)
               	movq	(%rdi), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	%r12, (%rsi)
               	movq	(%rdi), %rdi
               	xorq	%rdx, %rdx
               	movl	$0x85, %r12d
               	movq	%r12, (%rdi)
               	movq	%r12, (%rax)
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	movq	%rbx, %rdx
               	subq	%r12, %rdx
               	movq	%r12, %rsi
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	xorq	%rdi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdx)
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	addq	$0x48, %rdi
               	movq	%rdi, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x39, %rdx
               	setle	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	$0x30, %rdx
               	movq	%rdx, (%rsi)
               	cmpq	$0x0, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2f, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x80, %edx
               	movq	%rdx, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x78, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xa0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x30, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdx
               	movl	$0xa, %r11d
               	imulq	%r11, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rsi)
               	movzbq	(%rax), %rax
               	addq	%rax, %rdx
               	subq	$0x30, %rdx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movzbq	(%rdx), %rdx
               	cmpq	$0x39, %rdx
               	setle	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rdx
               	cmpq	$0x0, %rdx
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	movzbq	(%r12), %r12
               	movq	%r12, (%rdx)
               	movq	%r12, -0xa8(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r12
               	shlq	$0x4, %r12
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	andq	$0xf, %rax
               	addq	%rax, %r12
               	movq	(%rdx), %rdx
               	cmpq	$0x41, %rdx
               	jl	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x30, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xc0(%rbp)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x39, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %r12
               	movq	%r12, -0xb8(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x61, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xc8(%rbp)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	-0xb8(%rbp), %r12
               	movq	%r12, -0xb0(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x66, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc8(%rbp)
               	jmp	<addr>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, -0xb8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x41, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0xd0(%rbp)
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	-0xb0(%rbp), %r12
               	movq	%r12, -0xa8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x46, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	jmp	<addr>
               	movq	-0xd0(%rbp), %r12
               	movq	%r12, -0xb0(%rbp)
               	jmp	<addr>
               	movl	$0x9, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	addq	%rax, %r12
               	movq	%r12, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x30, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe0(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	shlq	$0x3, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rcx)
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rax
               	subq	$0x30, %rax
               	movq	%rax, (%r12)
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x2f, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x27, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xf0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %edx
               	movq	%rdx, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
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
               	movq	%rax, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x22, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	jmp	<addr>
               	movq	-0xf0(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x3d, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	%rsi, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rax)
               	movzbq	(%rsi), %rsi
               	movq	%rsi, (%r12)
               	cmpq	$0x5c, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x22, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	%r12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf8(%rbp)
               	jmp	<addr>
               	movq	-0xf8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r12
               	movq	%r12, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rsi)
               	movzbq	(%r12), %r12
               	movq	%r12, (%rcx)
               	cmpq	$0x6e, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x22, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movb	%dil, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x3d, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x95, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movl	$0x8e, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x2b, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2d, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %r12
               	movl	$0xa2, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x9d, %eax
               	movq	%rax, (%rdx)
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
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x21, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %rdx
               	movl	$0xa3, %eax
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9e, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x3d, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x3c, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x96, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x3d, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x99, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x3c, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x9b, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x97, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x3d, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x7c, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x9a, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x3e, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x9c, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x98, %eax
               	movq	%rax, (%rdx)
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
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x26, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %rdx
               	movl	$0x90, %eax
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x92, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movzbq	(%r12), %r12
               	xorq	$0x26, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x91, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movl	$0x94, %edx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x93, %eax
               	movq	%rax, (%rdx)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	leaq	<rip>, %r12
               	movl	$0xa1, %eax
               	movq	%rax, (%r12)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x9f, %eax
               	movq	%rax, (%rdx)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5b, %rax
               	jne	<addr>
               	leaq	<rip>, %r12
               	movl	$0xa4, %eax
               	movq	%rax, (%r12)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x8f, %eax
               	movq	%rax, (%rdx)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x3b, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x138(%rbp)
               	jmp	<addr>
               	movq	-0x138(%rbp), %r12
               	movq	%r12, -0x130(%rbp)
               	cmpq	$0x0, %r12
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x7d, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x128(%rbp)
               	jmp	<addr>
               	movq	-0x128(%rbp), %r12
               	movq	%r12, -0x120(%rbp)
               	cmpq	$0x0, %r12
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x29, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x118(%rbp)
               	jmp	<addr>
               	movq	-0x118(%rbp), %r12
               	movq	%r12, -0x110(%rbp)
               	cmpq	$0x0, %r12
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2c, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x108(%rbp)
               	jmp	<addr>
               	movq	-0x108(%rbp), %r12
               	movq	%r12, -0x100(%rbp)
               	cmpq	$0x0, %r12
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
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r9
               	movq	(%r9), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x80, %rdi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x1, %r12d
               	movq	%r12, (%rdi)
               	movq	(%rax), %r8
               	addq	$0x8, %r8
               	movq	%r8, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%r8)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	movq	(%rdi), %r8
               	addq	$0x8, %r8
               	movq	%r8, (%rdi)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	%r12, (%r8)
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x22, %r12
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	andq	$-0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %r8
               	movl	$0x2, %eax
               	movq	%rax, (%r8)
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x28, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x85, %rdi
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %eax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x8a, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x86, %rsi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x9f, %rsi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x2, %rsi
               	movq	%rsi, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x29, %rsi
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x1, %esi
               	movq	%rsi, (%rax)
               	movq	(%rdi), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdi)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, -0x30(%rbp)
               	jmp	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rdi
               	movq	%rdi, (%r12)
               	leaq	<rip>, %rsi
               	movl	$0x1, %edi
               	movq	%rdi, (%rsi)
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
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x28, %r12
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	xorq	%r12, %r12
               	movq	%r12, -0x8(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x29, %r12
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0xd, %esi
               	movq	%rsi, (%rdi)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x2c, %rdi
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	movq	-0x10(%rbp), %rdi
               	addq	$0x18, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x82, %rdi
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movq	-0x10(%rbp), %rsi
               	addq	$0x28, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, (%rdi)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x81, %rsi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movl	$0x3, %edi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x10(%rbp), %rdi
               	addq	$0x28, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x7, %esi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x8(%rbp), %rsi
               	movq	%rsi, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x1, %esi
               	movq	%rsi, (%rax)
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %r12
               	movq	%rsi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r12
               	cmpq	$0x84, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, (%r12)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	subq	%rax, %rsi
               	movq	%rsi, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movq	-0x10(%rbp), %rdi
               	addq	$0x20, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x83, %rsi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movl	$0x1, %edi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x10(%rbp), %rdi
               	addq	$0x28, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %r12d
               	movq	%r12, -0x38(%rbp)
               	jmp	<addr>
               	movl	$0x9, %r12d
               	movq	%r12, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %r12
               	movq	%r12, (%rax)
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9f, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x86, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x40(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %r12
               	movq	%r12, -0x8(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x9f, %r12
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
               	movq	%rax, %r12
               	jmp	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x94, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	subq	$0x2, %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %edi
               	movq	%rdi, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x9, %edi
               	movq	%rdi, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rdi
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$-0x8, %rdi
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x2, %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0xd, %esi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %esi
               	movq	%rsi, (%r12)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, (%rdi)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x11, %r12d
               	movq	%r12, (%rdx)
               	leaq	<rip>, %rax
               	movq	%rsi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0xd, %esi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %esi
               	movq	%rsi, (%rdx)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movabsq	$-0x1, %rdx
               	movq	%rdx, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xf, %edx
               	movq	%rdx, (%r12)
               	leaq	<rip>, %rax
               	movq	%rsi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %rdx
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %edi
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9e, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x1, %esi
               	movq	%rsi, (%rdi)
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
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rdi
               	movq	%rdi, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %r14d
               	movq	%r14, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rax)
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %esi
               	movq	%rsi, (%r12)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %edi
               	movq	%rdi, (%rax)
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
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	movl	$0xd, %r14d
               	movq	%r14, (%rax)
               	movq	(%rdi), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdi)
               	movl	$0xa, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	movq	(%rdi), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdi)
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2, %r12
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	movq	(%r14), %r14
               	cmpq	$0x9, %r14
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r14
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x9, %r12d
               	movq	%r12, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, -0x68(%rbp)
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, -0x68(%rbp)
               	jmp	<addr>
               	movq	-0x68(%rbp), %rdi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
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
               	movq	%r12, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rbx, %rdi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x8e, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
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
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x8f, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x80(%rbp)
               	jmp	<addr>
               	movq	-0x80(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xd, %edi
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rsi
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%rsi)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xc, %r14d
               	movq	%r14, -0x88(%rbp)
               	jmp	<addr>
               	movl	$0xb, %r14d
               	movq	%r14, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x88(%rbp), %r14
               	movq	%r14, (%rdi)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x4, %edi
               	movq	%rdi, (%r14)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, -0x10(%rbp)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x90, %r12
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	-0x10(%rbp), %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rsi
               	addq	$0x18, %rsi
               	movq	%rsi, (%rdi)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x2, %esi
               	movq	%rsi, (%r14)
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movq	%rdi, -0x10(%rbp)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r12), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x5, %edi
               	movq	%rdi, (%r12)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0x1, %r15d
               	movq	%r15, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	cmpq	$0x91, %r15
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x4, %edi
               	movq	%rdi, (%r15)
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movq	%r12, -0x10(%rbp)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%r14), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rdi
               	movl	$0x1, %r14d
               	movq	%r14, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x92, %r14
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %edi
               	movq	%rdi, (%r14)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xe, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x93, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0xf, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x94, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x10, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x95, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x11, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x96, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x12, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x97, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x13, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x98, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x14, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x99, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x15, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9a, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x16, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9b, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x17, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9c, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x18, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r12
               	movl	$0x1, %edi
               	movq	%rdi, (%r12)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9d, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdi)
               	movl	$0x9f, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, (%rax)
               	cmpq	$0x2, %rdi
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r14
               	cmpq	$0x9e, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0xd, %eax
               	movq	%rax, (%rdi)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movl	$0x8, %eax
               	movq	%rax, (%rdi)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1b, %eax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x19, %r14d
               	movq	%r14, (%r12)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9f, %edi
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x9f, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x1a, %r14d
               	movq	%r14, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%rdi)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x8, %edi
               	movq	%rdi, (%r12)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1c, %edi
               	movq	%rdi, (%rdx)
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, (%rax)
               	cmpq	$0x2, %rdi
               	jle	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r14)
               	movl	$0xd, %eax
               	movq	%rax, (%rdi)
               	movq	(%r14), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r14)
               	movl	$0x1, %eax
               	movq	%rax, (%rdx)
               	movq	(%r14), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r14)
               	movl	$0x8, %eax
               	movq	%rax, (%rdi)
               	movq	(%r14), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r14)
               	movl	$0x1b, %eax
               	movq	%rax, (%rdx)
               	movq	(%r14), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r14)
               	movl	$0x1a, %eax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1a, %edi
               	movq	%rdi, (%r14)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r14d
               	movq	%r14, (%rdi)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1b, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0xa0, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1c, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r14
               	movl	$0x1, %edi
               	movq	%rdi, (%r14)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0xa1, %rdi
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r15)
               	movl	$0xd, %r14d
               	movq	%r14, (%rdi)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1d, %edi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %r15
               	movl	$0x1, %edi
               	movq	%rdi, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0xa2, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x98(%rbp)
               	cmpq	$0x0, %rdi
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0xa4, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0xd, %r15d
               	movq	%r15, (%rdi)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0xa, %r15d
               	movq	%r15, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0xd, %esi
               	movq	%rsi, (%rax)
               	movq	(%rdi), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdi)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x2, %rsi
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	movq	(%r15), %r15
               	cmpq	$0x9, %r15
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r15
               	movl	$0xd, %edx
               	movq	%rdx, (%r15)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x9, %edx
               	movq	%rdx, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %rdi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %esi
               	movq	%rsi, -0xa8(%rbp)
               	jmp	<addr>
               	movl	$0x1a, %esi
               	movq	%rsi, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movl	$0xb, %eax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0xd, %esi
               	movq	%rsi, (%rax)
               	movq	(%rdi), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdi)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x2, %rsi
               	jle	<addr>
               	movl	$0x8, %edi
               	movq	%rdi, -0xb8(%rbp)
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rdi
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %esi
               	movq	%rsi, -0xc0(%rbp)
               	jmp	<addr>
               	movl	$0x19, %esi
               	movq	%rsi, -0xc0(%rbp)
               	jmp	<addr>
               	movq	-0xc0(%rbp), %rsi
               	movq	%rsi, (%rdi)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movl	$0xd, %edi
               	movq	%rdi, (%rsi)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdx
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	cmpq	$0x2, %rdi
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0xd, %esi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x8, %esi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1b, %esi
               	movq	%rsi, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x19, %r15d
               	movq	%r15, (%rax)
               	movq	(%rdi), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %r15
               	movq	-0x8(%rbp), %rdi
               	subq	$0x2, %rdi
               	movq	%rdi, (%r15)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movq	-0x8(%rbp), %rsi
               	cmpq	$0x2, %rsi
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
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
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
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
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r11
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r11
               	movq	(%r11), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x4, %esi
               	movq	%rsi, (%rax)
               	movq	(%rdi), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%rdi)
               	movq	%r11, -0x10(%rbp)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %r11
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x18, %rdi
               	movq	%rdi, (%r11)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	movl	$0x2, %edi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x10(%rbp)
               	callq	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %r11
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r11)
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x8b, %rbx
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %esi
               	movq	%rsi, (%rax)
               	movq	(%rbx), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%rbx)
               	movq	%r11, -0x10(%rbp)
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x2, %r11d
               	movq	%r11, (%rax)
               	movq	(%rbx), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rbx)
               	movq	-0x8(%rbp), %r11
               	movq	%r11, (%rsi)
               	movq	-0x10(%rbp), %rax
               	movq	(%rbx), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x7b, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x8, %r11d
               	movq	%r11, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x3b, %rdi
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x7d, %rdi
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %eax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x3b, %rdi
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
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
               	subq	$0x110, %rsp            # imm = 0x110
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
               	leaq	<rip>, %rdi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x20(%rbp), %rdi
               	movq	(%rdi), %rax
               	xorq	%rsi, %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	0x20(%rbp), %rsi
               	movq	(%rsi), %r9
               	movq	%r9, %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movl	$0x40000, %r10d         # imm = 0x40000
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %r14
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	%rax, (%r15)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %r14
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	xorq	%r15, %r15
               	movq	%rax, %rdi
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r14
               	movq	(%r14), %rdi
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x86, %r15d
               	movq	%r15, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x8d, %r15
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %rdi
               	movq	%rdi, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r15)
               	movq	%rdi, (%rax)
               	jmp	<addr>
               	movl	$0x1e, %edi
               	movq	%rdi, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x26, %rdi
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	addq	$0x18, %rdi
               	movl	$0x82, %ecx
               	movq	%rcx, (%rdi)
               	movq	(%rax), %r14
               	addq	$0x20, %r14
               	movl	$0x1, %ecx
               	movq	%rcx, (%r14)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rdi
               	movq	(%rdi), %rcx
               	movq	%rcx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %r15
               	movl	$0x86, %ecx
               	movq	%rcx, (%r15)
               	callq	<addr>
               	movq	(%r14), %r14
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	movq	%rax, (%r15)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	0x28(%rsp), %rdx
               	subq	$0x1, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x58(%rbp), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	-0x58(%rbp), %rax
               	addq	%rax, %rsi
               	xorq	%rax, %rax
               	movb	%al, (%rsi)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movl	$0x1, %ebx
               	movq	%rbx, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x8a, %rbx
               	jne	<addr>
               	jmp	<addr>
               	addq	$0x28, %r14
               	movq	(%r14), %r14
               	movq	%r14, -0x30(%rbp)
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x86, %rbx
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
               	movq	%rax, %rbx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7b, %rbx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x7b, %rbx
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
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rbx
               	cmpq	$0x85, %rbx
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rdx
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x8e, %rdx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	addq	$0x18, %rax
               	movl	$0x80, %edi
               	movq	%rdi, (%rax)
               	movq	(%rsi), %rdx
               	addq	$0x20, %rdx
               	movl	$0x1, %edi
               	movq	%rdi, (%rdx)
               	movq	(%rsi), %rsi
               	addq	$0x28, %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	%rdi, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x2c, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, -0x58(%rbp)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x7d, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movq	-0x18(%rbp), %r12
               	addq	$0x2, %r12
               	movq	%r12, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	cmpq	$0x85, %r12
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x20, %rax
               	movq	-0x18(%rbp), %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x28, %rdi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	addq	$0x18, %rdi
               	movl	$0x81, %eax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	addq	$0x28, %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rsi)
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	addq	$0x18, %rax
               	movl	$0x83, %r12d
               	movq	%r12, (%rax)
               	movq	(%rsi), %rsi
               	addq	$0x28, %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r12
               	movq	%r12, (%rsi)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, -0x18(%rbp)
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
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %rdx
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x18(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x9f, %rdx
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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x84, %rsi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x30, %rsi
               	movq	(%rax), %rdi
               	addq	$0x18, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %rdx
               	addq	$0x18, %rdx
               	movl	$0x84, %edi
               	movq	%rdi, (%rdx)
               	movq	(%rax), %rsi
               	addq	$0x38, %rsi
               	movq	(%rax), %rdi
               	addq	$0x20, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %rdx
               	addq	$0x20, %rdx
               	movq	-0x18(%rbp), %rdi
               	movq	%rdi, (%rdx)
               	movq	(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	(%rax), %rdi
               	addq	$0x28, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rdx
               	movq	(%rdx), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%rdx)
               	movq	%rdi, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rax)
               	movq	%rdi, (%rsi)
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x8a, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xc0(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x8a, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movl	$0x6, %esi
               	movq	%rsi, (%rax)
               	movq	(%rdi), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdi)
               	movq	-0x58(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	subq	%rdi, %rsi
               	movq	%rsi, (%r12)
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
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x3b, %rdi
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
               	movq	%rax, %rdi
               	movq	-0x18(%rbp), %rdi
               	addq	$0x2, %rdi
               	movq	%rdi, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x85, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x84, %rsi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	addq	$0x30, %rsi
               	movq	(%rax), %rdi
               	addq	$0x18, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %r12
               	addq	$0x18, %r12
               	movl	$0x84, %edi
               	movq	%rdi, (%r12)
               	movq	(%rax), %rsi
               	addq	$0x38, %rsi
               	movq	(%rax), %rdi
               	addq	$0x20, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %r12
               	addq	$0x20, %r12
               	movq	-0x18(%rbp), %rdi
               	movq	%rdi, (%r12)
               	movq	(%rax), %rsi
               	addq	$0x40, %rsi
               	movq	(%rax), %rdi
               	addq	$0x28, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, (%rsi)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %r12
               	movq	(%r12), %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r12)
               	movq	%rdi, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x7d, %rsi
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rsi)
               	movl	$0x8, %r12d
               	movq	%r12, (%rax)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	%r12, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	movq	(%r12), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	addq	$0x18, %rax
               	movq	(%r12), %rsi
               	addq	$0x30, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, (%rax)
               	movq	(%r12), %rdi
               	addq	$0x20, %rdi
               	movq	(%r12), %rsi
               	addq	$0x38, %rsi
               	movq	(%rsi), %rsi
               	movq	%rsi, (%rdi)
               	movq	(%r12), %rax
               	addq	$0x28, %rax
               	movq	(%r12), %r12
               	addq	$0x40, %r12
               	movq	(%r12), %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rsi
               	addq	$0x48, %rsi
               	movq	%rsi, (%r12)
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	-0x38(%rbp), %rdi
               	movq	0x28(%rsp), %r10
               	addq	%r10, %rdi
               	movq	%rdi, -0x38(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	addq	$-0x8, %rdi
               	movq	%rdi, (%rax)
               	movl	$0x26, %r14d
               	movq	%r14, (%rdi)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %edi
               	movq	%rdi, (%r14)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%rdi)
               	movq	0x10(%rbp), %r14
               	movq	%r14, (%rax)
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rdi)
               	movq	0x20(%rbp), %rax
               	movq	%rax, (%r14)
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%rdi)
               	movq	-0x60(%rbp), %r14
               	movq	%r14, (%rax)
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x50(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %r14
               	movq	(%r14), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	(%rdi), %rdi
               	movq	%rdi, -0x58(%rbp)
               	leaq	-0x50(%rbp), %r12
               	movq	(%r12), %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r12)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movq	-0x50(%rbp), %rsi
               	leaq	<rip>, %r12
               	movq	-0x58(%rbp), %r14
               	movl	$0x5, %r11d
               	imulq	%r11, %r14
               	movq	%r12, %rdx
               	addq	%r14, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rdi)
               	movq	(%rsi), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rsi), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rsi)
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdx
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	$-0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	-0x30(%rbp), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdx)
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
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
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
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
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r12)
               	movq	-0x40(%rbp), %rdx
               	movq	%rdx, (%rax)
               	movq	-0x38(%rbp), %r12
               	movq	%r12, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rdx), %rax
               	movq	%rax, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rdx)
               	movq	(%rax), %rax
               	shlq	$0x3, %rax
               	subq	%rax, %r12
               	movq	%r12, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x7, %r12
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %rdi
               	movq	%rdi, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movq	(%rdi), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	-0x40(%rbp), %rdi
               	movq	%rdi, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	%rdi, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rdi), %rdi
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %rdi
               	movq	%rdi, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rsi)
               	movq	(%rdi), %rdi
               	movq	%rdi, -0x30(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rdi
               	movzbq	(%rdi), %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0xb, %rdi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	%rdi, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	(%rdi), %rdi
               	movq	-0x48(%rbp), %rsi
               	movq	%rsi, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0xc, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rax
               	movb	%al, (%rsi)
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%rdi)
               	movq	-0x48(%rbp), %rsi
               	movq	%rsi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0xe, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	orq	%rdx, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0xf, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x10, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	andq	%rdx, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x11, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x12, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x13, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x14, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rsi
               	setg	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x15, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setle	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x16, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x17, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	%rdi, %rcx
               	shlq	%cl, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x18, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %rcx
               	sarq	%cl, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x19, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1a, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	subq	%rdx, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1b, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	imulq	%rdi, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1c, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1d, %rsi
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movq	(%rsi), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	%rdi, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1e, %rsi
               	jne	<addr>
               	movq	-0x38(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x8, %rsi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x1f, %rdi
               	jne	<addr>
               	movq	-0x38(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x10, %rdi
               	movq	(%rdi), %rax
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdx
               	movq	(%rsi), %rdi
               	movq	%rdx, %rsi
               	movq	%rdi, %rdx
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x20, %rsi
               	jne	<addr>
               	movq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rsi
               	movq	%rsi, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rsi
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rsi
               	movq	%rsi, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %rsi
               	addq	$-0x8, %rsi
               	movq	(%rsi), %rdi
               	movq	%rax, %rsi
               	addq	$-0x10, %rsi
               	movq	(%rsi), %rdx
               	movq	%rax, %rsi
               	addq	$-0x18, %rsi
               	movq	(%rsi), %r12
               	movq	%rax, %rsi
               	addq	$-0x20, %rsi
               	movq	(%rsi), %rcx
               	movq	%rax, %rsi
               	addq	$-0x28, %rsi
               	movq	(%rsi), %r8
               	addq	$-0x30, %rax
               	movq	(%rax), %r9
               	movq	%rdx, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %r9
               	movq	(%r9), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rdi
               	movq	(%rdi), %rax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x24, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r8
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rsi
               	movq	(%rdi), %rdx
               	movq	%r8, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rdx
               	movq	%rdx, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdi
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rsi
               	movq	(%rdx), %rax
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movq	%rdx, -0x48(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdx
               	cmpq	$0x26, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x38(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	-0x50(%rbp), %rdx
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdx
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	addb	%al, (%rax)
