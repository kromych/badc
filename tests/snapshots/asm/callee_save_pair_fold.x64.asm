
callee_save_pair_fold.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	testq	%rbx, %rbx
               	jg	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x1(%rbx), %rax
               	movslq	%eax, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<quad>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %rbx
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
