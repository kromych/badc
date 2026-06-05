
const_expr_conditional.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0xe, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	addq	$0xc, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
