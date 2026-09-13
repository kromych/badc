
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
               	movq	%rdi, %rax
               	prefetchnta	(%rax)
               	prefetcht0	(%rax)
               	prefetcht1	(%rax)
               	prefetcht2	(%rax)
               	prefetch	(%rax)
               	prefetchw	(%rax)
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
