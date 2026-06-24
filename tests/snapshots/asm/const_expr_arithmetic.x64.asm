
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
               	xorq	%rbx, %rbx
               	movl	$0x20, %eax
               	addq	%rbx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	movl	$0x40, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %ebx
               	movl	$0x40, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40, %eax
               	movl	$0x4, %ebx
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ebx
               	movl	$0x20, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x20, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %ebx
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x18, %eax
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ebx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
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
