
inline_asm_x64_prefetch.x64:	file format elf64-x86-64

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

<prefetch_hints>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	prefetchnta	(%rax)
               	prefetcht0	(%rax)
               	prefetcht1	(%rax)
               	prefetcht2	(%rax)
               	prefetch	(%rax)
               	prefetchw	(%rax)
               	movq	-0x10(%rbp), %rax
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
