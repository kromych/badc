
inline_asm_x64_c_mem.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax        # <addr>
               	leaq	-0x7(%rax), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
