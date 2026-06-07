
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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x20, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %ebx
               	jmp	<addr>
               	movl	$0x40, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %ebx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rbx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ebx
               	jmp	<addr>
               	movl	$0x20, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %ebx
               	jmp	<addr>
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	movl	$0x4, %ecx
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ebx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
