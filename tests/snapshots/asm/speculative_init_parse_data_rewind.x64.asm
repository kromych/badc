
speculative_init_parse_data_rewind.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x14, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
