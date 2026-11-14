
page_multiple_alignment.x64:	file format elf64-x86-64

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
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	0x4000(%rcx), %rdx
               	testl	$0x3fff, %edx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8000(%rcx), %rsi
               	testl	$0x3fff, %esi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	0xc000(%rcx), %rsi
               	testl	$0x3fff, %esi           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	addq	$0x10000, %rcx          # imm = 0x10000
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	0x1(%rax), %rcx
               	testl	$0x3fff, %ecx           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	addq	$0x2000, %rax           # imm = 0x2000
               	testl	$0x3fff, %eax           # imm = 0x3FFF
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0xb, <rip> # <addr>
               	movl	$0x16, <rip> # <addr>
               	movl	$0x21, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x14000, %rax          # imm = 0x14000
               	movl	$0x2c, (%rax)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x4000, %rax           # imm = 0x4000
               	movl	(%rax), %eax
               	cmpl	$0x21, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1e, %eax
               	retq
