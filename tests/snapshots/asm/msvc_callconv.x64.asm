
msvc_callconv.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_std>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<add_cdecl>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<add_fast>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<record>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x14, %edi
               	movl	$0x16, %esi
               	callq	*%rax
               	movl	$0x1, %ecx
               	addq	%rcx, %rcx
               	addq	%rcx, %rax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rax
               	movq	%r12, %rdi
               	callq	*%rax
               	cmpq	$0x33, %r12
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x33, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
