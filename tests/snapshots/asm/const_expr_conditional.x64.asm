
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
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	$0x7, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	$0xe, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	addq	$0xc, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
