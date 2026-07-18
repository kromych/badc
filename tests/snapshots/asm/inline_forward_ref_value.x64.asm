
inline_forward_ref_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<compute>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x64(%rdi), %rax
               	leaq	0x1(%rdi), %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	<rip>, %rdi
               	leaq	0x1(%rcx), %rax
               	movl	%eax, (%rdi)
               	leaq	(%rcx,%rsi), %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	retq
               	movabsq	$-0x2, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	subq	$0xde, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
