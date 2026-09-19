
vla_large_runtime.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shlq	$0x12, %rcx
               	movq	%rcx, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rsi, %rsp
               	xorl	%eax, %eax
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x1, (%rsi,%rax,4)
               	incq	%rax
               	cmpq	%rcx, %rax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	(%rsi,%rax,4), %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpq	%rcx, %rax
               	jl	<addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	$0x2a, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
