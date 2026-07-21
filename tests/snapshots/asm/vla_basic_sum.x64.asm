
vla_basic_sum.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	movq	%rdx, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	%rsi
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	(%rdx,%rsi,4), %r8
               	addq	%r8, %rcx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
