
memset_mcmp.x64:	file format elf64-x86-64

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
               	movl	$0x5, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movb	$0x41, (%rax)
               	movb	$0x41, 0x1(%rax)
               	movb	$0x41, 0x2(%rax)
               	movb	$0x41, 0x3(%rax)
               	movb	$0x0, 0x4(%rax)
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
