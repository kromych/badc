
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		outsb	(%rsi), %dx
               	movq	-0x48(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	leave
               	retq

<port_out_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		outsw	(%rsi), %dx
               	movq	-0x48(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	leave
               	retq

<port_out_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		outsl	(%rsi), %dx
               	movq	-0x48(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rsi
               	xorq	%rax, %rax
               	leave
               	retq

<port_in_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		insb	%dx, %es:(%rdi)
               	movq	-0x48(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rdi
               	xorq	%rax, %rax
               	leave
               	retq

<port_in_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		insw	%dx, %es:(%rdi)
               	movq	-0x48(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rdi
               	xorq	%rax, %rax
               	leave
               	retq

<port_in_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rcx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	-0x48(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x40(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x38(%rbp), %rdx
               	rep		insl	%dx, %es:(%rdi)
               	movq	-0x48(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x40(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rdi
               	xorq	%rax, %rax
               	leave
               	retq

<port_out_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x28(%rbp), %rdx
               	outsb	(%rsi), %dx
               	movq	-0x30(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rsi
               	xorq	%rax, %rax
               	leave
               	retq

<port_in_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdx, -0x40(%rbp)
               	movq	%rdi, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x30(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x28(%rbp), %rdx
               	insb	%dx, %es:(%rdi)
               	movq	-0x30(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rdi
               	xorq	%rax, %rax
               	leave
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
