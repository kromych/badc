
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
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rsi
               	movq	-0x20(%rbp), %rcx
               	rep		outsb	(%rsi), %dx
               	movq	%rsi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_out_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rsi
               	movq	-0x20(%rbp), %rcx
               	rep		outsw	(%rsi), %dx
               	movq	%rsi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_out_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rsi
               	movq	-0x20(%rbp), %rcx
               	rep		outsl	(%rsi), %dx
               	movq	%rsi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_in_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	rep		insb	%dx, %es:(%rdi)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_in_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	rep		insw	%dx, %es:(%rdi)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_in_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x30(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	rep		insl	%dx, %es:(%rdi)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq

<port_out_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rsi
               	outsb	(%rsi), %dx
               	movq	%rsi, -0x20(%rbp)
               	leave
               	retq

<port_in_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rdi
               	insb	%dx, %es:(%rdi)
               	movq	%rdi, -0x20(%rbp)
               	leave
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
