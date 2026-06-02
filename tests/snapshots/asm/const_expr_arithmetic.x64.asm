
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
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
               	leaq	<rip>, %rdi
               	movl	$0x20, %r9d
               	movl	$0x4, %r8d
               	movq	%r8, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %esi
               	movq	%rsi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %esi
               	movq	%rsi, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %r9d
               	movq	%r9, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %esi
               	movq	%rsi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	%ebx, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %ebx
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %ebx
               	movl	$0x4, %esi
               	movq	%rsi, %r11
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	popq	%rdx
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movl	$0x5, %esi
               	movl	%esi, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x20, %esi
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x8, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %esi
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
