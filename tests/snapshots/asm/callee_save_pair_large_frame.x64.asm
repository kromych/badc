
callee_save_pair_large_frame.x64:	file format elf64-x86-64

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

<bigframe>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x320(%rbp), %rax
               	movl	%ebx, (%rax)
               	leaq	-0x320(%rbp), %rax
               	movl	%r12d, 0x31c(%rax)
               	leaq	-0x320(%rbp), %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	leaq	-0x320(%rbp), %rcx
               	movslq	0x31c(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x340, %rsp            # imm = 0x340
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
