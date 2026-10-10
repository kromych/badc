
block_extern_unsized_array_decay.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
