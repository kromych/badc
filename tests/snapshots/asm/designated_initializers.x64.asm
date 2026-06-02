
designated_initializers.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x90(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x2, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	jmp	<addr>
               	movq	-0x90(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	popq	%r11
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0xa, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x98(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x63, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r9)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r9)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r9)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r9)
               	popq	%r11
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb0(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	jmp	<addr>
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x3, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	popq	%r11
               	leaq	-0x30(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0x7, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb8(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r9), %r11
               	movq	%r11, 0x8(%rax)
               	movzbq	0x10(%r9), %r11
               	movb	%r11b, 0x10(%rax)
               	movzbq	0x11(%r9), %r11
               	movb	%r11b, 0x11(%rax)
               	movzbq	0x12(%r9), %r11
               	movb	%r11b, 0x12(%rax)
               	movzbq	0x13(%r9), %r11
               	movb	%r11b, 0x13(%rax)
               	popq	%r11
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0xf, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r9), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%r9), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%r9), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%r9), %r11
               	movq	%r11, 0x20(%rax)
               	popq	%r11
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x17, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x1c, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x19, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x1a, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r9), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%r9), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x88(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x20, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x21, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x22, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x23, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x24, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
