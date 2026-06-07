
pointer_arithmetic.x64:	file format elf64-x86-64

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
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	movl	$0x1, %eax
               	movl	%eax, (%rdx)
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movslq	(%rdx), %rcx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
