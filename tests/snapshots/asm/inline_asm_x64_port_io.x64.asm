
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
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rdi, %rsi
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		outsb	(%rsi), %dx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rsi, %rax
               	leave
               	retq

<port_out_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rdi, %rsi
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		outsw	(%rsi), %dx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rsi, %rax
               	leave
               	retq

<port_out_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rdi, %rsi
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		outsl	(%rsi), %dx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rsi, %rax
               	leave
               	retq

<port_in_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		insb	%dx, %es:(%rdi)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdi, %rax
               	leave
               	retq

<port_in_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		insw	%dx, %es:(%rdi)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdi, %rax
               	leave
               	retq

<port_in_dwords>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	movq	-0x20(%rbp), %rcx
               	rep		insl	%dx, %es:(%rdi)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rdi, %rax
               	leave
               	retq

<port_out_one>:
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rdi, %rsi
               	movq	%rax, %rdx
               	outsb	(%rsi), %dx
               	movq	%rsi, %rax
               	retq

<port_in_one>:
               	movq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	insb	%dx, %es:(%rdi)
               	movq	%rdi, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
