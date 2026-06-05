
struct_2d_array_field.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movl	%eax, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x40(%rbp)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x50(%rbp)
               	movl	%ecx, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	-0x38(%rbp), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movslq	-0x40(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpq	$0x3, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x40(%rbp)
               	jmp	<addr>
               	movslq	-0x50(%rbp), %rax
               	subq	$0x6f, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x40(%rbp), %rcx
               	cmpq	$0x4, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	movslq	-0x38(%rbp), %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	-0x40(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
