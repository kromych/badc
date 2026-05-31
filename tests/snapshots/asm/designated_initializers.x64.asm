
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
               	subq	$0xc0, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r9
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
               	movq	%r9, %r11
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %r11
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x63, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	jmp	<addr>
               	movq	-0xa0(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r11
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%r11)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%r11)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%r11)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%r11)
               	popq	%rcx
               	movq	%r11, %r9
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
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
               	movslq	(%r9), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	jmp	<addr>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r11
               	leaq	-0x30(%rbp), %r11
               	movslq	(%r11), %r9
               	cmpq	$0x7, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb8(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	-0x30(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r9
               	cmpq	$0xe, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xb8(%rbp)
               	jmp	<addr>
               	movq	-0xb8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r9)
               	movzbq	0x10(%rax), %r11
               	movb	%r11b, 0x10(%r9)
               	movzbq	0x11(%rax), %r11
               	movb	%r11b, 0x11(%r9)
               	movzbq	0x12(%rax), %r11
               	movb	%r11b, 0x12(%r9)
               	movzbq	0x13(%rax), %r11
               	movb	%r11b, 0x13(%r9)
               	popq	%r11
               	movq	%r9, %r11
               	leaq	-0x48(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0xf, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %r11
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r11), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%r11), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%r11), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%r11), %rcx
               	movq	%rcx, 0x20(%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x70(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x1c, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r11
               	addq	$0x24, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x1a, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %r11
               	pushq	%rcx
               	movq	(%r11), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r11), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%r11), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x88(%rbp), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x20, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x22, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x32, %r11
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %r11
               	addq	$0x14, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x24, %r11d
               	movq	%r11, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
