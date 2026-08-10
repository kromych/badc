
phi_group_dead_phi_interference.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x60(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	movq	%rdi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	xorq	%rcx, %rcx
               	xorq	%rdx, %rdx
               	movq	%rdi, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movzwq	(%rdx), %rcx
               	movq	0x8(%rdx), %rdx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x5, %rsi
               	jl	<addr>
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	%rdi, %rax
               	movabsq	$-0x2ec4a3831a650f4b, %rcx # imm = 0xD13B5C7CE59AF0B5
               	xorq	%rax, %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	cmpq	$0x35, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
