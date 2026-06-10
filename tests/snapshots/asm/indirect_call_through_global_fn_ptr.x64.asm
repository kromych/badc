
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rsi, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
