
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<do_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rsi, %rax
               	addq	%rdx, %rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x23, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rbx
               	movslq	(%rax), %rsi
               	movslq	%edx, %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movslq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
