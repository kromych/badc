
indirect_call_narrow_scalar_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take>:
               	movsbq	%dil, %rdi
               	movswq	%si, %rsi
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rdx       # <addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	movslq	%edi, %rax
               	movsbq	%al, %rcx
               	movswq	%ax, %rsi
               	imulq	$0x186a0, %rcx, %rax    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rbx
               	movq	%rdx, %rax
               	movq	%rdi, %rsi
               	movq	%rdi, %rdx
               	callq	*%rax
               	movslq	%eax, %rax
               	movslq	%ebx, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
