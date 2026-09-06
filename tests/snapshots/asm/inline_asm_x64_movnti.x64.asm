
inline_asm_x64_movnti.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2a, %eax
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	movntil	%ebx, (%rax)
               	sfence
               	movslq	-0x8(%rbp), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
