
inline_forward_ref_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<combine>:
               	leaq	<rip>, %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, (%rcx)
               	leaq	(%rdi,%rsi), %rax
               	retq

<scale>:
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	retq

<compute>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rbx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x64(%rdi), %rax
               	leaq	0x1(%rdi), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	shlq	$0x1, %rax
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	subq	$0xde, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
