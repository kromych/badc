
const_expr_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
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
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
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
