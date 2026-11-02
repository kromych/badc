
max_alignment_placement.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	testl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	addq	$0x10000, %rcx          # imm = 0x10000
               	testl	$0xffff, %ecx           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	0x1(%rax), %rdx
               	testl	$0xffff, %edx           # imm = 0xFFFF
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	addq	$0x8000, %rax           # imm = 0x8000
               	testl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	$0xb, <rip> # <addr>
               	movq	$0x16, <rip> # <addr>
               	movq	$0x21, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x16, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10000, %rax          # imm = 0x10000
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorl	%eax, %eax
               	retq
