
inline_forward_ref_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<compute>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x64(%rdi), %rax
               	incq	%rdi
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	<rip>, %r8
               	leaq	0x1(%rcx), %rax
               	movl	%eax, (%r8)
               	leaq	(%rcx,%rdi), %rax
               	addq	%rdx, %rax
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
               	leaq	<rip>, %rax
               	movl	$0xd3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xde, %eax
               	xorq	%rax, %rax
               	retq
