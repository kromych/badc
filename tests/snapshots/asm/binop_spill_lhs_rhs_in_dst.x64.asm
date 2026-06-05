
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	(%rsi), %rsi
               	xorq	%r8, %r8
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	%rdx, %rcx
               	jg	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rcx)
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	movslq	-0x8(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rax, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %r8
               	jmp	<addr>
               	movslq	%r8d, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
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
