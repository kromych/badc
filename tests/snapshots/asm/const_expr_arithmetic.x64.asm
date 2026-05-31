
const_expr_arithmetic.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x20, %r9d
               	movl	$0x4, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x8, %r9
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x20, %r9d
               	movl	$0x4, %r8d
               	movq	%r8, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movl	$0x18, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %r15
               	movl	$0x40, %eax
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x40, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r15
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	%r12d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %r12d
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %r12
               	je	<addr>
               	leaq	<rip>, %r14
               	movl	$0x18, %r12d
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x20, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %r15
               	movl	$0x20, %eax
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x18, %eax
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
