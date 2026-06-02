
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
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
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
               	movl	$0x4, %edi
               	movq	%rdi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %r8d
               	movq	%r8, %r11
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
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %edi
               	movq	%rdi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %r8d
               	movq	%r8, %r11
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
               	movl	$0x4, %edi
               	movq	%rdi, %r11
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
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x20, %eax
               	movl	$0x4, %edi
               	movq	%rdi, %r11
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	popq	%rdx
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	movl	$0x4, %esi
               	movq	%rsi, %r11
               	pushq	%rax
               	pushq	%rdx
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
               	movl	$0x4, %edi
               	movq	%rdi, %r11
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
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rsi
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
