
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
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rcx
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
