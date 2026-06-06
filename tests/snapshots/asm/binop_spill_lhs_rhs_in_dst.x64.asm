
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rdx, %rcx
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rax, %rdx
               	movslq	(%rdx), %rdx
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movslq	%r8d, %rsi
               	cmpq	%rcx, %rsi
               	jg	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rsi
               	movq	%rsi, %r8
               	addq	$0x1, %r8
               	jmp	<addr>
               	movslq	%edi, %rsi
               	movslq	%r8d, %rdi
               	shlq	$0x2, %rdi
               	addq	%rax, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	movslq	%edi, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0xc, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %edx
               	addq	$0x4, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0xf, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0xc, %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
