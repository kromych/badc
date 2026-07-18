
flexible_array_member_after_tentative_decl.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<early_ref>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	cmpq	%rax, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x8(%rsi), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x10(%rsi), %rdx
               	movq	(%rdx,%rcx,8), %rdi
               	leaq	0xa(%rcx), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0xb, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
