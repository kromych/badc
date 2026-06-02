
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
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %r11
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movq	%r9, (%r8)
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
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
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$-0x1, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x50(%rbp)
               	cmpq	$0x0, %rdi
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
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
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
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rdi)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movl	$0x1, %edi
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
