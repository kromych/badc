
inline_asm_x64_port_io.x64:	file format elf64-x86-64

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

<port_out_bytes>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		outsb	(%rsi), %dx
               	movq	-0x18(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rsi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_out_words>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		outsw	(%rsi), %dx
               	movq	-0x18(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rsi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_out_dwords>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		outsl	(%rsi), %dx
               	movq	-0x18(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rsi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_in_bytes>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		insb	%dx, %es:(%rdi)
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_in_words>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		insw	%dx, %es:(%rdi)
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_in_dwords>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rdx
               	rep		insl	%dx, %es:(%rdi)
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<port_out_one>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdx, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x8(%rbp), %rdx
               	outsb	(%rsi), %dx
               	movq	-0x10(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x20(%rbp), %rdx
               	movq	-0x18(%rbp), %rsi
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<port_in_one>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdx, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x8(%rbp), %rdx
               	insb	%dx, %es:(%rdi)
               	movq	-0x10(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x20(%rbp), %rdx
               	movq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
