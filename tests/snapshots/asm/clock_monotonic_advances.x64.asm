
clock_monotonic_advances.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x10(%rbp), %r11
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movq	%r9, (%r8)
               	movl	$0x1, %ebx
               	leaq	-0x10(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r12
               	cmpq	$-0x1, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r12
               	cmpq	$0x0, %r12
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r12
               	cmpq	$0x0, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x50(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %r12
               	movslq	(%r12), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r14d
               	leaq	-0x20(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %r15
               	movq	(%r15), %r15
               	cmpq	%r15, %rax
               	jge	<addr>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %r15
               	movq	(%r15), %r15
               	cmpq	%r15, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r15
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r15
               	setl	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
