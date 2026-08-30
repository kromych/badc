
inline_asm_a64_st4_lane.x64:	file format elf64-x86-64

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

<st4_lane_words>:
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
