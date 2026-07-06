
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
               	leaq	-<rip>, %rax       # <addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	movslq	%edi, %rcx
               	movsbq	%cl, %rdx
               	movswq	%cx, %rsi
               	imulq	$0x186a0, %rdx, %rcx    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rdx
               	addq	%rdx, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rbx
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
