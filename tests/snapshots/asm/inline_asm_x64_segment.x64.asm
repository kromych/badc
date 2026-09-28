
inline_asm_x64_segment.x64:	file format elf64-x86-64

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
               	movq	%fs:0x0, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%r10d, %r10d
               	movq	%fs:(%r10), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
