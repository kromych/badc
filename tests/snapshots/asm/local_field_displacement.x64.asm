
local_field_displacement.x64:	file format elf64-x86-64

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

<write_all>:
               	leaq	0x1(%rsi), %rax
               	movq	%rax, (%rdi)
               	leaq	0x2(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	0x3(%rsi), %rax
               	movq	%rax, 0x10(%rdi)
               	leaq	0x4(%rsi), %rax
               	movq	%rax, 0x18(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	movb	%al, -0x1000(%rbp)
               	leaq	-0x1020(%rbp), %rdi
               	movq	%rax, -0x1020(%rbp)
               	movl	$0x2, %ecx
               	movq	%rcx, -0x1018(%rbp)
               	movl	$0x3, %edx
               	movq	%rdx, -0x1010(%rbp)
               	movl	$0x4, %esi
               	movq	%rsi, -0x1008(%rbp)
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	callq	<addr>
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1010(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1008(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x1000(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	subq	$0x32, %rax
               	leave
               	retq
