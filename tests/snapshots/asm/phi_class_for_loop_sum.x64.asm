
phi_class_for_loop_sum.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rcx)
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movslq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	movslq	%edx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	popq	%rbp
               	jmp	<addr>
