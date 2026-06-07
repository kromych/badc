
struct_basic.x64:	file format elf64-x86-64

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
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %edx
               	movl	%edx, 0x4(%rax)
               	movslq	%ecx, %rdx
               	movslq	%ecx, %rcx
               	imulq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x4, %rax
               	movslq	(%rax), %rdx
               	movq	%rdx, %rax
               	imulq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
