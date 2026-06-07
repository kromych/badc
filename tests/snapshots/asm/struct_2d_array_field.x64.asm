
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movslq	%ecx, %r8
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xa, %r8, %r8
               	movslq	%r8d, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movslq	%edx, %rax
               	subq	$0x6f, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	jmp	<addr>
               	movslq	%edx, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	movq	%rax, %r8
               	addq	%rsi, %r8
               	movslq	%edi, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	movslq	(%r8), %rsi
               	addq	%rsi, %rdx
               	jmp	<addr>
               	jmp	<addr>
