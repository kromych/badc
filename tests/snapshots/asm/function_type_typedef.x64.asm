
function_type_typedef.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<call_via_ptr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<call_via_decay>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rdi, %rax
               	movq	%rsi, %rdi
               	movq	%rdx, %rsi
               	callq	*%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0xa, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0x14, %esi
               	movl	$0x8, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
