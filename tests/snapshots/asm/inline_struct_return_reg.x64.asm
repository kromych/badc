
inline_struct_return_reg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<steal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<read_bits>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	%ecx, %rdx
               	leaq	-0x40(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rsi
               	movq	%rsi, (%rax,%rdx,8)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	addq	$0x0, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x55, %rax
               	cmpq	$0xa055, %rax           # imm = 0xA055
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
