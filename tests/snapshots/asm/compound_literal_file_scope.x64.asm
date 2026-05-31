
compound_literal_file_scope.x64:	file format elf64-x86-64

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
               	movq	(%r9), %r8
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
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %r11
               	movq	(%r11), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x1, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	<rip>, %r9
               	movq	(%r9), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x4, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %r9
               	movq	%r9, -0x8(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x4, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x2, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x20(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x8, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x72, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r11
               	addq	$0x10, %r11
               	movq	(%r11), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x0, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %r11
               	movq	%r11, -0x30(%rbp)
               	cmpq	$0x0, %r11
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
