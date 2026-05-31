
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
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r12
               	cmpq	$-0x1, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
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
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	$0x0, %rax
               	jge	<addr>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x0, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x50(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x3b9aca00, %r12       # imm = 0x3B9ACA00
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x28(%rbp)
               	movl	%r12d, -0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x30(%rbp), %r12
               	cmpq	$0xf4240, %r12          # imm = 0xF4240
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x28(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r14d
               	leaq	-0x20(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r12
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r14
               	cmpq	%r14, %r12
               	jge	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %rax
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r14
               	cmpq	%r14, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %r14
               	addq	$0x8, %r14
               	movq	(%r14), %rax
               	leaq	-0x10(%rbp), %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r12
               	cmpq	%r12, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
