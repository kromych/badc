
inline_forward_ref_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<combine>:
               	leaq	<rip>, %rax
               	movq	%rdi, %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	(%rdi,%rsi), %rax
               	retq

<scale>:
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	retq

<compute>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rbx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %r12
               	addq	$0x64, %r12
               	movq	%rdi, %r13
               	incq	%r13
               	testq	%r12, %r12
               	jne	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rcx
               	shlq	$0x1, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	subq	$0xde, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
